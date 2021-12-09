//
// Created by shubh on 24/03/2021.
//

#ifndef RAYTRACER_OBJECT_H
#define RAYTRACER_OBJECT_H

#include <memory>
#include <iostream>
#include <optional>

#include "math/utils.h"
#include "camera/Ray.h"
#include "texture_material/texture_material.h"

class Object
{
public:
    DEV explicit Object() : origin(0,0,0), texmat(new UniformTexture()) {};
    DEV explicit Object(const Point3& v);
    DEV Point3 get_origin() const;

    DEV void set_origin(const Point3& o);

    DEV void set_texmat(TextureMaterial* tm);

    DEV  virtual bool bool_intersect(const Ray& ray) = 0;

    DEV  virtual float intersect(const Ray& ray) = 0;

    DEV  virtual Vector3 normal(const Point3& o) const = 0;

    DEV virtual MaterialParameter get_param_at(const Point3& point) const = 0;

    DEV virtual Color get_color(const Point3& point) const = 0;

   //  DEV virtual Object* cuda_Object() const = 0;

    TextureMaterial* texmat;

protected:
    Point3 origin;
};

using sObject = std::shared_ptr<Object>;

#endif //RAYTRACER_OBJECT_H
