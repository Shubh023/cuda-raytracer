//
// Created by shubh on 24/03/2021.
//

#ifndef RAYTRACER_TEXTUREMATERIAL_H
#define RAYTRACER_TEXTUREMATERIAL_H

#include "../math/utils.h"
#include "../image/Color.h"
#include "../Macros.h"
#include <iostream>
#include <memory>

struct MaterialParameter
{
    DEV MaterialParameter(const Color& c, float diff=0.0, float spec=0.0, float refrac=0.0, float transp = 0.0)
            : color(c), diffusion(diff), specularity(spec), refractivity(refrac), transparency(transp)
    {};
    DEV void set_color(Color& c) { color = c;}
    DEV void set_diffusion(float diff) { diffusion = diff;}
    DEV void set_specularity(float spec) { specularity = spec;}
    DEV void set_refractivity(float refrac) { refractivity = refrac;}
    DEV void set_transparency(float transp) { transparency = transp;}


    Color color;
    float diffusion;
    float specularity;
    float refractivity;
    float transparency;
};

class TextureMaterial
{
public:
    DEV TextureMaterial() {};
    DEV virtual ~TextureMaterial() {};
    DEV virtual MaterialParameter get_texmat(const P3& pos) const = 0;
    DEV virtual Color get_color(const P3& pos) const = 0;
};

using sTexture = std::shared_ptr<TextureMaterial>;

#endif //RAYTRACER_TEXTUREMATERIAL_H
