#include "UVTexture.h"

DEV UVTexture::UVTexture(Color* _colors) : mp(Color(0,0,0))
{
    colors = _colors;
}

DEV MaterialParameter UVTexture::get_texmat(const Point3 &pos) const {
    return mp;
}

DEV Color UVTexture::get_color(const Point3 &pos) const {
    int u = 0;
    int v = 0;
    return mp.color;
};