//
// Created by shubh on 24/03/2021.
//

#include "UniformTexture.h"

DEV  UniformTexture::UniformTexture(const Color& color) : mp(color)
{}

DEV UniformTexture::UniformTexture() : UniformTexture(Color(0.1, 0.4, 0.95))
{}


DEV UniformTexture::UniformTexture(float r, float g, float b) : UniformTexture(Color(r, g, b))
{}

DEV MaterialParameter UniformTexture::get_texmat(const Point3& pos) const {
    return mp;
}

DEV Color UniformTexture::get_color(const Point3 &pos) const {
    return mp.color;
}
