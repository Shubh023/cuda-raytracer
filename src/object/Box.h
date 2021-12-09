#ifndef RAYTRACER_BOX_H
#define RAYTRACER_BOX_H

#include "Object.h"

class Box : public Object {
public:
    DEV explicit Box(const P3 _min, const P3 _max) : min(_min), max(_max) {};

    DEV bool bool_intersect(const Ray& ray) override;
    DEV float intersect(const Ray& ray) override;
    DEV V3 normal(const P3& point) const override;
    DEV MaterialParameter get_param_at(const P3& point) const final;
    DEV Color get_color(const P3& point) const final;

private:
    P3 min;
    P3 max;
};


#endif //RAYTRACER_BOX_H
