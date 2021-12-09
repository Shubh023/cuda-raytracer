//
// Created by shubh on 25/03/2021.
//

#ifndef RAYTRACER_PLANE_H
#define RAYTRACER_PLANE_H

#include "Object.h"

class Plane : public Object {
public:
    DEV explicit Plane(const P3 &o, V3 u);

    DEV bool bool_intersect(const Ray& ray) override;
    DEV float intersect(const Ray& ray) override;
    DEV V3 normal(const P3& point) const override;
    DEV MaterialParameter get_param_at(const P3& point) const final;
    DEV Color get_color(const P3& point) const final;

private:
    V3 n;
};


#endif //RAYTRACER_PLANE_H
