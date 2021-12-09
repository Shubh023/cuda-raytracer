//
// Created by shubh on 24/03/2021.
//

#ifndef RAYTRACER_LIGHT_H
#define RAYTRACER_LIGHT_H

#include <memory>

#include "math/utils.h"
#include "object/Object.h"

const float SPECULAR_NS = 4.0;

class Light {
public:
    DEV Light(Point3& p, Color& c, double i) : position(p), color(c), intensity(i) {};
    // DEV virtual bool hide_light(Point3 from, sObject o);
    DEV virtual Color get_color(const P3& p) const = 0;
    DEV virtual V3 get_direction(const P3& p) const = 0;
    DEV virtual double get_intensity(const P3& p) const = 0;

    DEV Point3 get_origin() const { return position; };
    DEV void set_color(const Color& c) { color = c; };
    DEV void set_origin(const Point3& p) { position = p; };
protected:
    Point3 position;
    Color color;
    double intensity;
};

using sLight = std::shared_ptr<Light>;

#endif //RAYTRACER_LIGHT_H
