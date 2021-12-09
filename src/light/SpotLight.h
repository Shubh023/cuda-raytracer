//
// Created by shubh on 3/29/21.
//

#ifndef RAYTRACER_SPOTLIGHT_H
#define RAYTRACER_SPOTLIGHT_H

#include "Light.h"

class SpotLight: public Light {
public:
    DEV SpotLight(Point3 pos, Color c, double intensity, const P3& _target, double innerA, double outerA);
    DEV Color get_color(const P3& p) const override;
    DEV V3 get_direction(const P3& p) const override;
    DEV double get_intensity(const P3 &p) const override;

protected:
    P3 target;
    double innerAngle;
    double outerAngle;
    // double attenutation;
};


#endif //RAYTRACER_SPOTLIGHT_H
