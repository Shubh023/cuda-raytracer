//
// Created by shubh on 25/03/2021.
//

#include "Sphere.h"

DEV Sphere::Sphere(float x, float y, float z, float r) : Object(P3(x,y,z)), radius(r)
{}

DEV Sphere::Sphere(const P3 &o, float r) : Object(o), radius(r)
{}

DEV float Sphere::get_radius() const {
    return radius;
}

DEV void Sphere::set_radius(float r) {
    radius = r;
}

DEV float Sphere::intersect(const Ray &ray)
{
    V3 oc = ray.origin - origin;
    float b = 2 * oc.dot(ray.direction);
    float a = ray.direction.length();
    float c = oc.length() - radius*radius;
    float discriminant = b * b - 4 * a * c;
    if(discriminant < 0)
        return -1;
    float t = (-b - std::sqrt(discriminant)) / 2;
    if (t > 0)
        return t;
    return -1;
}

DEV bool Sphere::bool_intersect(const Ray &ray)
{
    return (intersect(ray) > 0);
}

DEV V3 Sphere::normal(const P3 &point) const {
    return (point - origin).normalized();
}

DEV MaterialParameter Sphere::get_param_at(const P3 &point) const {
    return texmat->get_texmat(point);
}

DEV Color Sphere::get_color(const P3 &point) const {
    return texmat->get_color(point);
}
