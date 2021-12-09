#include "ParametricTexture.h"

#include "ParametricTexture.h"

DEV  ParametricTexture::ParametricTexture(Color (*f)(P3)) : mp(Color(1,1,1))
{
    parametric_color = [f](P3 p) {return f(p);};
}

DEV MaterialParameter ParametricTexture::get_texmat(const Point3& pos) const {
    Color col = parametric_color(pos);
    MaterialParameter new_mp(col);
    return new_mp;
}

DEV Color ParametricTexture::get_color(const Point3 &pos) const {
    Color col = parametric_color(pos);
    return col;
}