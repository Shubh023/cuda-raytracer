//
// Created by shubh on 24/03/2021.
//

#ifndef RAYTRACER_POINTLIGHT_H
#define RAYTRACER_POINTLIGHT_H

#include "Light.h"

class PointLight: public Light {
public:
    DEV PointLight(Point3 pos, Color c, double intensity);
    DEV Color get_color(const P3& p) const override;
    DEV V3 get_direction(const P3& p) const override;
    DEV double get_intensity(const P3 &p) const override;
};


#endif //RAYTRACER_POINTLIGHT_H
