//
// Created by shubh on 24/03/2021.
//

#ifndef RAYTRACER_UNIFORMTEXTURE_H
#define RAYTRACER_UNIFORMTEXTURE_H

#include "TextureMaterial.h"

class UniformTexture : public TextureMaterial
{
public:
    DEV UniformTexture();
    DEV UniformTexture(float r, float g, float b);
    DEV explicit UniformTexture(const Color& color);
    DEV MaterialParameter get_texmat(const Point3& pos) const final;
    DEV Color get_color(const Point3& pos) const final;

    DEV void set_color(Color& c) { mp.set_color(c);}
    DEV void set_diffusion(float diff) { mp.set_diffusion(diff);}
    DEV void set_specularity(float spec) { mp.set_specularity(spec);}
    DEV void set_refractivity(float refrac) { mp.set_refractivity(refrac);}
    DEV void set_transparency(float transp) { mp.set_transparency(transp);}


private:
    MaterialParameter mp;
};

#endif //RAYTRACER_UNIFORMTEXTURE_H
