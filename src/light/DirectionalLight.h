//
// Created by shubh on 3/27/21.
//

#ifndef RAYTRACER_DIRECTIONALLIGHT_H
#define RAYTRACER_DIRECTIONALLIGHT_H


#include "Light.h"

class DirectionalLight: public Light {
public:
    DEV DirectionalLight(Point3 pos, Color c, double intensity, V3 dir);
    DEV Color get_color(const P3& p) const override;
    DEV V3 get_direction(const P3& p) const override;
    DEV double get_intensity(const P3 &p) const override;

protected:
    V3 direction;
};


#endif //RAYTRACER_DIRECTIONALLIGHT_H
