#pragma once
#include <iostream>
#include <experimental/optional>
#include <utility>
#include "image/Image.h"
#include "camera/Ray.h"
#include "scene/Scene.h"
#include "object/Object.h"
#include <cfloat>


#define DEFAULT_DEPTH 2

struct nearest_object {
    float t;
    Object* closest;
};


Image& render(Scene* scene, Color* colors, int height, int width);
DEV Color raytrace(Scene& scene, Ray &ray, int depth=DEFAULT_DEPTH);
DEV nearest_object find_nearest_object(Scene& scene, Ray &ray);
DEV Color get_color(Scene& scene, const Object* obj, Point3 pos, Vector3 normal, Vector3 reflected);
