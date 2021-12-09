//
// Created by shubh on 3/27/21.
//

#include "DirectionalLight.h"

DEV DirectionalLight::DirectionalLight(Point3 pos, Color c, double _intensity, V3 dir)
    : Light(pos, c, _intensity), direction(dir)
{}

DEV Color DirectionalLight::get_color(const P3 &p) const {
    return (color * get_intensity(p)).clamp(0,1);
}

DEV V3 DirectionalLight::get_direction(const P3 &p) const {
    return direction.normalized();
}

DEV double DirectionalLight::get_intensity(const P3 &p) const {
    return intensity;
}