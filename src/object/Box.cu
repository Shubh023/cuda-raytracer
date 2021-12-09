#include "Box.h"

DEV float Box::intersect(const Ray &ray) {
    float tmin, tmax, tymin, tymax, tzmin, tzmax;
    if (ray.direction.x() >= 0) {
        tmin = (min.x - ray.origin.x) / ray.direction.x();
        tmax = (max.x - ray.origin.x) / ray.direction.x();
    }
    else {
        tmin = (max.x - ray.origin.x) / ray.direction.x();
        tmax = (min.x - ray.origin.x) / ray.direction.x();
    }
    if (ray.direction.y() >= 0) {
        tymin = (min.y - ray.origin.y) / ray.direction.y();
        tymax = (max.y - ray.origin.y) / ray.direction.y();
    } else {
        tymin = (max.y - ray.origin.y) / ray.direction.y();
        tymax = (min.y - ray.origin.y) / ray.direction.y();
    }
    if ((tmin > tymax) || (tymin > tmax)) {
        return -1;
    }
    if (tymin > tmin) {
        tmin = tymin;
    }
    if (tymax < tmax) {
        tmax = tymax;
    }
    if (ray.direction.z() >= 0) {
        tzmin = (min.z - ray.origin.z) / ray.direction.z();
        tzmax = (max.z - ray.origin.z) / ray.direction.z();
    } else {
        tzmin = (max.z - ray.origin.z) / ray.direction.z();
        tzmax = (min.z - ray.origin.z) / ray.direction.z();
    }
    if ((tmin > tzmax) || (tzmin > tmax)) {
        return -1;
    }
    if (tzmin > tmin) {
        tmin = tzmin;
    }
    if (tzmax < tmax) {
        tmax = tzmax;
    }
    return tmin;
}


DEV bool Box::bool_intersect(const Ray &ray) {

    return (intersect(ray) > 0);
}

DEV V3 Box::normal(const P3 &point) const {
    V3 normal;
    P3 size(abs(min.x - max.x),
            abs(min.y - max.y),
            abs(min.z - max.z));
    V3 localpoint = (point - P3(0,0,0)) - (max - size * 0.5);

    float mini = std::numeric_limits<float>::max();
    float distance = std::abs(size.x - abs(localpoint.x()));
    if (distance < mini)
    {
        mini = distance;
        normal.set(1,0,0);
        int sign = (localpoint.x() < 0) ? -1 : 1;
        normal *= sign;
    }
    distance = std::abs(size.y - abs(localpoint.y()));
    if (distance < mini)
    {
        mini = distance;
        normal.set(0,1,0);
        int sign = (localpoint.y() < 0) ? -1 : 1;
        normal *= sign;
    }
    distance = std::abs(size.z - abs(localpoint.z()));
    if (distance < mini)
    {
        mini = distance;
        normal.set(0,0,1);
        int sign = (localpoint.z() < 0) ? -1 : 1;
        normal *= sign;
    }
    return normal.normalized();
}

DEV MaterialParameter Box::get_param_at(const P3 &point) const {
    return texmat->get_texmat(point);
}

DEV Color Box::get_color(const P3 &point) const {
    return texmat->get_color(point);
}


