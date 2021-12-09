//
// Created by shubh on 25/03/2021.
//

#include "Object.h"


DEV Object::Object(const Point3& v) : origin(v), texmat(new UniformTexture())
{}

DEV void Object::set_texmat(TextureMaterial* tm)
{
    texmat = tm;
}

DEV Point3 Object::get_origin() const {
    return origin;
}

DEV void Object::set_origin(const Point3& o) {
    origin = o;
}
