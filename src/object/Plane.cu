//
// Created by shubh on 25/03/2021.
//

#include "Plane.h"

DEV Plane::Plane(const P3& o, V3 u) : Object(o), n(u) {}

DEV float Plane::intersect(const Ray &ray) {
    auto direction = ray.direction;
    float denom = n.dot(direction);
    if (denom > 1e-4)
    {
        V3 p = (origin - ray.origin);
        float t = n.dot(p) / denom;
        return t;
    }
    return -1;
}

DEV bool Plane::bool_intersect(const Ray &ray) {
    return (intersect(ray) > 0);
}

DEV V3 Plane::normal(const P3 &point) const {
    return n;
}

DEV MaterialParameter Plane::get_param_at(const P3 &point) const {
    return texmat->get_texmat(point);
}

DEV Color Plane::get_color(const P3 &point) const {
    return texmat->get_color(point);
}
