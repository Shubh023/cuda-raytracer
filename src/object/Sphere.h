//
// Created by shubh on 25/03/2021.
//

#ifndef RAYTRACER_SPHERE_H
#define RAYTRACER_SPHERE_H

#include "Object.h"

class Sphere : public Object
{
public:
    DEV Sphere(float x, float y, float z, float r);
    DEV Sphere(const P3& o, float r);
    DEV float get_radius() const;
    DEV void set_radius(float r);

    DEV bool bool_intersect(const Ray& ray) override;
    DEV float intersect(const Ray& ray) override;
    DEV V3 normal(const P3& point) const override;
    DEV MaterialParameter get_param_at(const P3& point) const final;
    DEV Color get_color(const P3& point) const final;

    // DEV virtual Object* cuda_Object() const = 0;

private:
    float radius;
};


#endif //RAYTRACER_SPHERE_H
