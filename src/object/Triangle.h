#pragma once

#include "Object.h"

class Triangle: public Object {
public:
    DEV Triangle(Point3 _a, Point3 _b, Point3 _c);

    DEV bool bool_intersect(const Ray& ray) override;
    DEV float intersect(const Ray& ray) override;
    DEV V3 normal(const P3& point) const override;
    DEV MaterialParameter get_param_at(const P3& point) const final;
    DEV Color get_color(const P3& point) const final;

    Point3 a;
    Point3 b;
    Point3 c;
    Vector3 AB, AC;
};
