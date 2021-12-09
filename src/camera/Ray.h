#pragma once

#include "../math/Point3.h"

class Ray {
public:
    DEV Ray(const Point3 &o, const Vector3 &d): origin(o), direction(d)
    {}


    DEV Point3 times(float t) const {
        return origin + (direction * t);
    }

    Point3 origin;
    Vector3 direction;
};
