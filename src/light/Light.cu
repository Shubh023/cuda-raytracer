//
// Created by shubh on 24/03/2021.
//

#include "Light.h"
/*
DEV bool Light::hide_light(Point3 from, sObject o) {
    Vector3 L = position - from;
    Vector3 Lu = L.normalize();
    if (!o->bool_intersect(Ray(from, Lu)))
        return false;

    auto t = o->intersect(Ray(from, Lu));
    return t < L.norm();
}
 */