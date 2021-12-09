#include <iostream>
#include "cuda_runtime.h"

#include "Macros.h"
#include "math/utils.h"
#include "image/Image.h"
#include "engine/Engine.h"
#include "engine/Engine.h"
#include "light/PointLight.h"
#include "light/DirectionalLight.h"
#include "light/SpotLight.h"
#include "object/Sphere.h"
#include "object/Plane.h"
#include "object/Triangle.h"
#include "object/Box.h"
#include "object/Blob.h"
#include "object/SmoothTriangle.h"
#include "texture_material/ChequeredTexture.h"
#include "texture_material/ParametricTexture.h"

#define IMAGE_WIDTH 2200
#define IMAGE_HEIGHT 2000

void check_cud(cudaError_t result, char const *const func, const char *const file, int const line) {
    if (result) {
        std::cerr << "CUDA error = " << static_cast<unsigned int>(result) << " at " <<
                  file << ":" << line << " '" << func << "' \n";
        // Make sure we call CUDA Device Reset before exiting
        cudaDeviceReset();
        exit(99);
    }
}

DEV void cursedSpheres(Scene* scene, P3 origin, float rayon, int i)
{
    if (!i)
        return;
    auto sphere = new Sphere(origin, rayon);
    Color col(i * 0.25,i * 0.5,i * 0.75);
    auto texmat = new UniformTexture(col.clamp(0.f,1.f));
    texmat->set_diffusion(1);
    texmat->set_specularity(1);
    sphere->set_texmat(texmat);
    scene->add_object(sphere);
    int r = rayon * 1.25;
    cursedSpheres(scene, origin + P3(r,0,0), rayon * 1/2, i - 1);
    cursedSpheres(scene, origin + P3(-r,0,0), rayon * 1/2, i - 1);
    cursedSpheres(scene, origin + P3(0, r,0), rayon * 1/2, i - 1);
    cursedSpheres(scene, origin + P3(0, -r,0), rayon * 1/2, i - 1);
    cursedSpheres(scene, origin + P3(0,0,-r), rayon * 1/2, i - 1);
    cursedSpheres(scene, origin + P3(0,0,r), rayon * 1/2, i - 1);
}

GBL void spheresfractal(Scene* d_scene)
{

    uint width = IMAGE_WIDTH;
    uint height = IMAGE_HEIGHT;
    double alpha = 45 * M_PI / 180;
    double beta = std::atan(double(height * std::tan(alpha)) / width);

    // Camera
    Point3 cam_pos(0, 0, -90);
    Point3 cam_target(0, 0, 0);
    V3 up(0, 1, 0);

    Camera* cam = new Camera(cam_pos, cam_target, up, alpha, beta, 2);
    cam->rotate(0 * M_PI / 180,  0 * M_PI / 180, 0 * M_PI / 180);

    Scene* scene = new Scene(cam, 800, 10);
    // Colors
    Color red(1, 0, 0);
    Color green(0, 1, 0);
    Color blue(0, 0, 1);
    Color orange(1, 0.5, 0);
    Color white(1, 1, 1);
    Color black(0, 0, 0);

    // Textures
    // Texture Red
    auto TexRed = new UniformTexture(red);
    TexRed->set_diffusion(0.8);
    TexRed->set_specularity(0.2);
    TexRed->set_refractivity(1.0);
    // Texture Green
    auto TexGreen =new UniformTexture(green);
    TexGreen->set_diffusion(0.8);
    TexGreen->set_specularity(0.2);
    //TexGreen->set_refractivity(1.15);

    // Texture Blue
    auto TexBlue = new UniformTexture(blue);
    TexBlue->set_diffusion(0.8);
    TexBlue->set_specularity(0.2);
    //TexBlue->set_refractivity(1.15);
    // Texture Orange
    auto TexOrange = new UniformTexture(white);
    TexOrange->set_diffusion(1);
    TexOrange->set_specularity(0.1);
    // Texture White
    auto TexWhite = new UniformTexture(white);
    TexWhite->set_diffusion(0.1);
    TexWhite->set_specularity(0.0);
    TexWhite->set_refractivity(0.05);
    TexWhite->set_transparency(1.0);

    // Texture 2
    auto Cheq = new ChequeredBoardMaterial(white, black);
    Cheq->set_diffusion(0,1);
    Cheq->set_diffusion(1,0);
    Cheq->set_specularity(0,0.1);
    Cheq->set_specularity(1,0.0);

    // Lights
    // Lights
    Point3 l1(1, 1, -1);
    Vector3 direction = l1 - P3(0,0,0);
    auto light1 = new DirectionalLight(l1, white, 1, direction);
    scene->add_light(light1);

    Point3 l2(-1, 1, -1);
    Vector3 direction2 = l2 - P3(0,0,0);
    auto light2 = new DirectionalLight(l2, white, 1, direction2);
    scene->add_light(light2);

    Point3 l3(0, 0, -1);
    Vector3 direction3 = l2 - P3(0,0,0);
    auto light3 = new DirectionalLight(l3, white, 1, direction3);
    scene->add_light(light3);

    Point3 l4(0, 0, -5);
    auto light4 = new PointLight(l4, white, 20);
    // scene->add_light(light4);

    auto camlight = new SpotLight(cam->get_origin(), white, 0.5, cam->get_target(),
                                  60 * (M_PI/180),
                                  80 * (M_PI/180));
    scene->add_light(camlight);

    // Plane
    auto plane = new Plane(P3(0,0,10), Vector3(0,0,1));
    plane->set_texmat(TexRed);
    scene->add_object(plane);


    int size = 10;
    int rayon = 10;
    P3 origin(0, 0, 0);

    cursedSpheres(scene,origin,rayon, 4);

    scene->set_camera(width, height);
    *d_scene = *scene;
}


int main(int argc, char* argv[])
{

    int devNum = 0;
    checkCudaErrors(cudaGetDevice(&devNum));
    checkCudaErrors(cudaSetDevice(devNum));

    std::cout << "argc : " << argc << std::endl;
    uint width = IMAGE_WIDTH;
    uint height = IMAGE_HEIGHT;

    size_t size;
    cudaDeviceGetLimit(&size, cudaLimitStackSize);
    std::cout << "Stack size limit: " << size << "\n";
    checkCudaErrors(cudaDeviceSetLimit(cudaLimitStackSize, 102400));
    cudaDeviceGetLimit(&size, cudaLimitStackSize);
    std::cout << "New stack size limit: " << size << "\n";

    Color *d_colors;
    int col_size = sizeof(Color) * width * height;
    checkCudaErrors(cudaMalloc((void**)&d_colors, col_size));
    Scene* scene;
    checkCudaErrors(cudaMalloc((void**)&scene, sizeof(Scene)));

    spheresfractal<<<1,1>>>(scene);
    checkCudaErrors(cudaGetLastError());
    checkCudaErrors(cudaDeviceSynchronize());

    auto image = render(scene, d_colors, width, height);
    image.save("img.ppm");
    cudaFree(d_colors);
    cudaFree(scene);
    cudaDeviceReset();

    return 0;
}
