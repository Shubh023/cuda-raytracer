//
// Created by shubh on 3/29/21.
//

#include "SpotLight.h"

DEV SpotLight::SpotLight(Point3 pos, Color c, double _intensity, const P3& _target, double innerA, double outerA)
        : Light(pos, c, _intensity), target(_target), innerAngle(innerA), outerAngle(outerA)
{}

DEV V3 SpotLight::get_direction(const P3 &p) const {
    return (get_origin() - p).normalize();
}


DEV  Color SpotLight::get_color(const P3 &p) const {
    V3 toSurface = (get_origin() - p).normalize();

    double angle = std::acos(toSurface.dot(get_direction(target)));
    if (angle > innerAngle + outerAngle) {
        return Color(0, 0, 0);
    }
    double diffuse = max(get_direction(target).dot(get_direction(p)), 0.1);
    diffuse *= (1.0 / toSurface.length());
    if (angle > innerAngle) {
        // double factor =  1 - ((angle - innerAngle) / outerAngle);
        double factor =  (angle - innerAngle) * (1 / (outerAngle - innerAngle));
        return ((Color(std::max(0.0, (color.r() / 255.0) * factor),
                     std::max(0.0, (color.g() / 255.0) * factor),
                     std::max(0.0, (color.b() / 255.0) * factor)) * intensity) * diffuse).clamp(0.0,1.0);
    }
    else
        return ((color * intensity) * diffuse).clamp(0.0,1.0);
}

DEV double SpotLight::get_intensity(const P3 &p) const {
    return intensity;
}



