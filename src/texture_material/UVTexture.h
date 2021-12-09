//
// Created by shubh on 4/15/21.
//

#ifndef RAYTRACER_UVTEXTURE_H
#define RAYTRACER_UVTEXTURE_H

#include "TextureMaterial.h"

class UVTexture : public TextureMaterial
{
public:
    DEV explicit UVTexture(Color* colors) ; // Load a ppm file into a Color array to map a picture via uv mapping
    DEV MaterialParameter get_texmat(const Point3& pos) const final;
    DEV Color get_color(const Point3& pos) const final;

    DEV void set_color(Color& c) { mp.set_color(c);}
    DEV void set_diffusion(float diff) { mp.set_diffusion(diff);}
    DEV void set_specularity(float spec) { mp.set_specularity(spec);}
    DEV void set_refractivity(float refrac) { mp.set_refractivity(refrac);}
    DEV void set_transparency(float transp) { mp.set_transparency(transp);}


private:
    MaterialParameter mp;
    Color* colors;
};

#endif //RAYTRACER_UVTEXTURE_H
