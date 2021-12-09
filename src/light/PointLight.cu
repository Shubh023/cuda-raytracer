//
// Created by shubh on 24/03/2021.
//

#include "PointLight.h"



DEV PointLight::PointLight(Point3 pos, Color c, double i)
        : Light(pos, c, i){}

DEV Color PointLight::get_color(const P3 &p) const {
    return ((color * intensity) / (get_origin() - p).length());
}

DEV V3 PointLight::get_direction(const P3 &p) const {
    return (get_origin() - p).normalize();
}

DEV double PointLight::get_intensity(const P3 &p) const {
    return intensity;
}
