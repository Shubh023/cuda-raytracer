#include <fstream>
#include <iostream>
#include <iomanip>
#include "cuda_runtime.h"

#include "Engine.h"
#include "object/Blob.h"
#include "image/Color.h"
#include "cmdline/MSG.h"

// Sample x & y positions for 4x AA
DEV static const float SAMPLE_4x[4 * 2] = {
    -1.0/4.0,  3.0/4.0,
     3.0/4.0,  1.0/3.0,
    -3.0/4.0, -1.0/4.0,
     1.0/4.0, -3.0/4.0,
};

// Sample x & y positions for 8x AA
DEV static const float SAMPLE_8x[8 * 2] = {
    -7.0f / 8.0f,  1.0f/ 8.0f,
    -5.0f / 8.0f, -5.0f / 8.0f,
    -1.0f / 8.0f, -3.0f / 8.0f,
     3.0f / 8.0f, -7.0f / 8.0f,
     5.0f / 8.0f, -1.0f / 8.0f,
     7.0f / 8.0f,  7.0f / 8.0f,
     1.0f / 8.0f,  3.0f / 8.0f,
    -3.0f / 8.0f,  5.0f / 8.0f
};

// Sample x & y positions for 16x AA
DEV static const float SAMPLE_16x[16 * 2] = {
    -8.0f / 8.0f,  0.0f / 8.0f,
    -6.0f / 8.0f, -4.0f / 8.0f,
    -3.0f / 8.0f, -2.0f / 8.0f,
    -2.0f / 8.0f, -6.0f / 8.0f,
     1.0f / 8.0f, -1.0f / 8.0f,
     2.0f / 8.0f, -5.0f / 8.0f,
     6.0f / 8.0f, -7.0f / 8.0f,
     5.0f / 8.0f, -3.0f / 8.0f,
     4.0f / 8.0f,  1.0f / 8.0f,
     7.0f / 8.0f,  4.0f / 8.0f,
     3.0f / 8.0f,  5.0f / 8.0f,
     0.0f / 8.0f,  7.0f / 8.0f,
    -1.0f / 8.0f,  3.0f / 8.0f,
    -4.0f / 8.0f,  6.0f / 8.0f,
    -7.0f / 8.0f,  8.0f / 8.0f,
    -5.0f / 8.0f,  2.0f / 8.0f
};

#define MAX_DEPTH 3

GBL void pixel_render(Color* colors, Scene* scene, int width, int height)
{
    int i = threadIdx.x + blockIdx.x * blockDim.x;
    int j = threadIdx.y + blockIdx.y * blockDim.y;
    if((i >= width) || (j >= height)) return;
    size_t pixel_index = j*width + i;
    auto cam = scene->get_camera();
    auto ray = cam->compute_ray(j,i);
    auto c = raytrace(*scene, ray, MAX_DEPTH);
    /*
    int samples = 16;
    float u = 0;
    float v = 0;
    for(int s=0; s < samples; s++){
        u = i + SAMPLE_16x[2 * s];
        v = j + SAMPLE_16x[2 * s + 1];
        ray = cam->compute_ray(v,u);
        c += raytrace(*scene, ray, MAX_DEPTH);
    }
    c /= float(samples + 1);
    */
    c.clamp();
    colors[pixel_index] = c;
}

Image& render(Scene* scene, Color* d_colors, int width, int height) {

    int nx = width;
    int ny = height;
    int tx = 8;
    int ty = 8;
    dim3 blocks(nx/tx+1,ny/ty+1);
    dim3 threads(tx,ty);
    pixel_render<<<blocks,threads>>>(d_colors, scene, nx,ny);
    checkCudaErrors(cudaGetLastError());
    checkCudaErrors(cudaDeviceSynchronize());

    Image* image = new Image(width, height);
    Color* colors = new Color[height * width];

    auto col1 = cudaMemcpy(colors, d_colors, sizeof(Color) * width * height, cudaMemcpyDeviceToHost);
    for (int j = height-1; j >= 0; j--) {
        for (int i = 0; i < width; i++) {
            size_t pixel_index = j*width + i;
            Color c = colors[pixel_index];
            // c.print();
            image->set_pixel(j,i,c);
        }
    }
    return *image;
}



DEV Color raytrace(Scene& scene, Ray &ray, int depth) {
    if (depth < 0)
        return scene.get_background(ray);

    nearest_object hit_pair = find_nearest_object(scene, ray);

    if (hit_pair.t == FLT_MAX or hit_pair.closest == nullptr)
        return scene.get_background(ray);

    Point3 hit_pos = ray.origin + ray.direction * hit_pair.t;
    Vector3 hit_normal = hit_pair.closest->normal(hit_pos);
    if (hit_normal % ray.direction > 0)
        hit_normal = -hit_normal;

    Vector3 reflected = ray.direction - (hit_normal * 2) * (ray.direction % hit_normal);
    MaterialParameter mp = hit_pair.closest->get_param_at(hit_pos);

    Color diffspec = get_color(scene, hit_pair.closest, hit_pos, hit_normal, reflected);
    Color reflection;

    if (mp.specularity) {
        auto mod_hit_pos = hit_pos + 0.001 * reflected; // Handle float approximation error
        Ray new_ray = Ray(mod_hit_pos, reflected);
        reflection += raytrace(scene, new_ray, depth - 1);
        reflection *= mp.specularity * mp.color;
    }
    Color refraction;
    if (mp.refractivity)
    {
        float etar = mp.refractivity;
        auto N = hit_normal.normalize();
        auto V = ray.direction.normalize();
        float first_comp = etar * (N.dot(V));
        float second_comp = std::sqrt(1 - std::pow(etar, 2) * (1 - std::pow(N.dot(V),2)));
        V3 refracted = (first_comp - second_comp) * N - etar * V;
        auto mod_hit_pos = hit_pos + 0.001 * refracted; // Handle float approximation error
        Ray T(mod_hit_pos, refracted);
        float kr = mp.transparency;
        refraction += kr * raytrace(scene,T, depth - 1);
    }
    return diffspec + reflection + refraction;
}


DEV nearest_object find_nearest_object(Scene& scene, Ray &ray) {
    float tmin = FLT_MAX;
    Object* closest = nullptr;

    for (int i = 0; i < scene.get_co(); i++) {
        Object* obj = scene.get_objects()[i];
        auto t = obj->intersect(ray);
        if (t > 0 && t < tmin) {
            tmin = t;
            closest = obj;
        }
    }
    nearest_object result = {};
    if (closest) {
        result.t = tmin;
        result.closest = closest;
        return result;
    }
    result.t = FLT_MAX;
    result.closest = nullptr;
    return result;
}

DEV Color get_color(Scene& scene, const Object* obj, Point3 pos, Vector3 normal, Vector3 reflected) {
    MaterialParameter mp = obj->get_param_at(pos);

    Color color;
    auto objects = scene.get_objects();
    for (int i = 0; i < scene.get_cl(); i++) {
        auto light = scene.get_lights()[i];

        bool hidden = false;
        for (auto j = 0; j < scene.get_co(); j++) {
            auto light_obj = objects[j];
            if (light_obj != obj) {
                auto light_direction = (light->get_origin() - pos);
                auto light_distance = light_direction.norm();
                Ray ray(pos, light_direction.normalize());
                auto t = light_obj->intersect(ray);
                if (t > 0 && t < light_distance) {
                    hidden = true;
                    break;
                }
            }
        }
        if (!hidden) {
            Vector3 to_light = light->get_direction(pos);
            float d_contribution = to_light % normal;
            float r_contribution = to_light % reflected;
            if (r_contribution > 0)
                r_contribution = std::pow(float(to_light % reflected), SPECULAR_NS);

            Color light_contrib = mp.color;

            if (d_contribution < 0)
                d_contribution = 0;
            light_contrib *= light->get_color(pos) * (d_contribution * mp.diffusion);

            if (r_contribution > 0)
                light_contrib += light->get_color(pos) * (r_contribution * mp.specularity);

            color += light_contrib;
        }
    }

    return color;
}
