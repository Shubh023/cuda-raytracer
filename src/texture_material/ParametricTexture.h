//
// Created by shubh on 4/15/21.
//

#ifndef RAYTRACER_PARAMETRICTEXTURE_H
#define RAYTRACER_PARAMETRICTEXTURE_H


#include "TextureMaterial.h"
#include <nvfunctional>

class ParametricTexture : public TextureMaterial
{
public:
    DEV ParametricTexture(Color (*f)(P3));

    DEV MaterialParameter get_texmat(const Point3& pos) const override;
    DEV Color get_color(const Point3& pos) const final;

    DEV void set_color(Color& c) { mp.set_color(c);}
    DEV void set_diffusion(float diff) { mp.set_diffusion(diff);}
    DEV void set_specularity(float spec) { mp.set_specularity(spec);}
    DEV void set_refractivity(float refrac) { mp.set_refractivity(refrac);}
    DEV void set_transparency(float transp) { mp.set_transparency(transp);}

private:
    MaterialParameter mp;
    nvstd::function<Color(P3)> parametric_color;
};

#endif //RAYTRACER_PARAMETRICTEXTURE_H
