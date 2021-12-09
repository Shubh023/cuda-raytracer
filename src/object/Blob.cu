#include "Blob.h"
#include "Triangle.h"

/*
DEV Blob** blobs = new Blob*[200];
*/

DEV float Blob::compute_potential(Point3 &p) {
    float potential = 0;
    potential = this->potential(p);
    /*
    for (auto blob: Blob::blobs) {
        potential += blob->potential(p);
    }
    */
    return potential;
}


DEV void Blob::set_potential(double (*f)(P3, P3)) {
    P3 center = (origin + opposite) / 2;
    potential = [center, f] (P3 p) { return f(center, p); };
}


DEV void Blob::generate(Scene& scene) {
    const V3 off[8] = {V3(0, 1, 1), V3(1, 1, 1), V3(1, 1, 0), V3(0, 1, 0),
                           V3(0, 0, 1), V3(1, 0, 1), V3(1, 0, 0), V3(0, 0, 0)};

    auto light_blue = new UniformTexture(Color(1, 1, 1));
    auto light_green = new UniformTexture(Color(1, 1, 1));
    auto orange = new UniformTexture(Color(1, 1,  1));
    light_blue->set_diffusion(1);
    light_green->set_diffusion(1);
    orange->set_diffusion(1);

    Point3 cube[8];
    float potentials[8];
    for (int i = 0; i < 8; ++i)
        cube[i] = origin + step * off[i];

    int nstep = (float)BLOB_SIDE / step;
    for (int x = 0; x < nstep; ++x ) {
        for (int y = 0; y < nstep; ++y) {
            for (int z = 0; z < nstep; ++z) {
                int index = 0;
                for (int i = 0; i < 8; ++i) {
                    potentials[i] = Blob::compute_potential(cube[i]);
                    if (potentials[i] < threshold)
                        index |= 1 << i;
                }
                for (int i = 0; i < 15; i += 3) {
                    if (configurations[index][i] == -1) // No more triangle
                        break;
                    P3 t1 = interpolate_point(configurations[index][i], cube, potentials);
                    P3 t2 = interpolate_point(configurations[index][i + 1], cube, potentials);
                    P3 t3 = interpolate_point(configurations[index][i + 2], cube, potentials);
                    Object* tri = new Triangle(t1, t2, t3);
                    if ((x + y) % 3 == 0)
                        tri->set_texmat(light_blue);
                    else if ((x + y) % 3 == 1)
                        tri->set_texmat(light_green);
                    else
                        tri->set_texmat(orange);
                    tri->set_texmat(light_blue);
                    if (meshsize < 400) {
                        mesh[meshsize++] = tri;
                        // meshsize++;
                        scene.add_object(tri);
                    }

                    else
                        printf("Maximum meshSize reached");
                }
                // Step forward in Z direction
                cube[3] = cube[0];
                cube[2] = cube[1];
                cube[7] = cube[4];
                cube[6] = cube[5];
                cube[0].z += step;
                cube[1].z += step;
                cube[4].z += step;
                cube[5].z += step;
            }
            // Reset Z coord and step forward Y direction
            for (int i = 0; i < 8; ++i)
                cube[i].z = origin.z + step * off[i].z();
            cube[4] = cube[0];
            cube[5] = cube[1];
            cube[6] = cube[2];
            cube[7] = cube[3];
            cube[0].y += step;
            cube[1].y += step;
            cube[2].y += step;
            cube[3].y += step;
        }
        // Reset Y coord and step forward X direction
        for (int i = 0; i < 8; ++i)
            cube[i].y = origin.y + step * off[i].y();
        cube[1] = cube[0];
        cube[3] = cube[2];
        cube[5] = cube[4];
        cube[7] = cube[6];
        cube[0].x += step;
        cube[2].x += step;
        cube[4].x += step;
        cube[6].x += step;
    }
    printf("Generated %d triangles", meshsize);
}

DEV Object* Blob::get_last_hitted() {
    return hitted;
}

DEV bool Blob::bool_intersect(const Ray& ray) {
    if (!intersect_bounding_box(ray))
        return false;

    double t;
    for (int m = 0; m < meshsize; m++) {
        auto obj = mesh[m];
        t = obj->intersect(ray);
        if (t != -1)
            return true;
    }

    return false;
}

DEV float Blob::intersect(const Ray& ray) {
    if (!intersect_bounding_box(ray))
        return -1;

    double t;
    for (int m = 0; m < meshsize; m++) {
        auto obj = mesh[m];
        t = obj->intersect(ray);
        if (t != -1) {
            hitted = obj;
            return t;
        }
    }

    return -1;
}

DEV Vector3 Blob::normal(const Point3& o) const {
    return Vector3();
}

DEV MaterialParameter Blob::get_param_at(const Point3& point) const {
    return MaterialParameter(Color(1,1,1));
}

DEV Color Blob::get_color(const Point3& point) const {
    return Color(1,1,1);
}

DEV Point3 Blob::get_opposite() const {
    return opposite;
}

DEV void swapab(float & a, float & b)
{
    float tmp = a;
    a = b;
    b = tmp;
}

DEV bool Blob::intersect_bounding_box(const Ray& ray) const {
    float txmin, txmax, tymin, tymax, tzmin, tzmax;

    // First compute intersection in (xy) plan
    txmin = (origin.x - ray.origin.x) / ray.direction.x();
    txmax = (opposite.x - ray.origin.x) / ray.direction.x();
    if (txmin > txmax) swapab(txmin, txmax);

    tymin = (origin.y - ray.origin.y) / ray.direction.y();
    tymax = (opposite.y - ray.origin.y) / ray.direction.y();
    if (tymin > tymax) swapab(tymin, tymax);

    if (txmin > tymax || tymin > txmax) // No intersection en (xy) plan
        return false;

    // Permute t to get values for which it hits the box
    if (tymin > txmin)
        txmin = tymin;
    if (tymax < txmax)
        txmax = tymax;

    tzmin = (origin.z - ray.origin.z) / ray.direction.z();
    tzmax = (opposite.z - ray.origin.z) / ray.direction.z();
    if (tzmin > tzmax) swapab(tzmin, tzmax);

    if (txmin > tzmax || tzmin > txmax) // No intersection
        return false;

    if (tzmin > txmin)
        txmin = tzmin;
    if (txmin < 0)
        return false;
    return true;
}

DEV P3 Blob::interpolate_point(int edge, P3 vertices[8], float potentials[8]) {
    P3 v1, v2;
    float p1, p2;
    switch (edge) {
        case 0:
            v1 = vertices[0];
            v2 = vertices[1];
            p1 = potentials[0];
            p2 = potentials[1];
            break;
        case 1:
            v1 = vertices[1];
            v2 = vertices[2];
            p1 = potentials[1];
            p2 = potentials[2];
            break;
        case 2:
            v1 = vertices[2];
            v2 = vertices[3];
            p1 = potentials[2];
            p2 = potentials[3];
            break;
        case 3:
            v1 = vertices[3];
            v2 = vertices[0];
            p1 = potentials[3];
            p2 = potentials[0];
            break;
        case 4:
            v1 = vertices[4];
            v2 = vertices[5];
            p1 = potentials[4];
            p2 = potentials[5];
            break;
        case 5:
            v1 = vertices[5];
            v2 = vertices[6];
            p1 = potentials[5];
            p2 = potentials[6];
            break;
        case 6:
            v1 = vertices[6];
            v2 = vertices[7];
            p1 = potentials[6];
            p2 = potentials[7];
            break;
        case 7:
            v1 = vertices[7];
            v2 = vertices[4];
            p1 = potentials[7];
            p2 = potentials[4];
            break;
        case 8:
            v1 = vertices[0];
            v2 = vertices[7];
            p1 = potentials[0];
            p2 = potentials[7];
            break;
        case 9:
            v1 = vertices[1];
            v2 = vertices[5];
            p1 = potentials[1];
            p2 = potentials[5];
            break;
        case 10:
            v1 = vertices[2];
            v2 = vertices[6];
            p1 = potentials[2];
            p2 = potentials[6];
            break;
        case 11:
            v1 = vertices[3];
            v2 = vertices[7];
            p1 = potentials[3];
            p2 = potentials[7];
            break;
    }

    float mu = (threshold - p1) / (p2 - p1);
    if (mu > 1) return v2;
    if (mu < -1) return v1;
    double x = v1.x * (1 - mu) + v2.x * mu;
    double y = v1.y * (1 - mu) + v2.y * mu;
    double z = v1.z * (1 - mu) + v2.z * mu;

    return P3(x, y, z);
}

DEV P3 get_middle_point(int edge, P3 vertices[8]) {
    P3 v1, v2;
    switch (edge) {
        case 0:
            v1 = vertices[0];
            v2 = vertices[1];
            break;
        case 1:
            v1 = vertices[1];
            v2 = vertices[2];
            break;
        case 2:
            v1 = vertices[2];
            v2 = vertices[3];
            break;
        case 3:
            v1 = vertices[3];
            v2 = vertices[0];
            break;
        case 4:
            v1 = vertices[4];
            v2 = vertices[5];
            break;
        case 5:
            v1 = vertices[5];
            v2 = vertices[6];
            break;
        case 6:
            v1 = vertices[6];
            v2 = vertices[7];
            break;
        case 7:
            v1 = vertices[7];
            v2 = vertices[4];
            break;
        case 8:
            v1 = vertices[0];
            v2 = vertices[7];
            break;
        case 9:
            v1 = vertices[1];
            v2 = vertices[5];
            break;
        case 10:
            v1 = vertices[2];
            v2 = vertices[6];
            break;
        case 11:
            v1 = vertices[3];
            v2 = vertices[7];
            break;
    }
    double x = (v1.x + v2.x) / 2;
    double y = (v1.y + v2.y) / 2;
    double z = (v1.z + v2.z) / 2;

    return P3(x, y, z);
}