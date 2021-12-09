//
// Created by shubh on 25/03/2021.
//

#ifndef RAYTRACER_CHEQUEREDTEXTURE_H
#define RAYTRACER_CHEQUEREDTEXTURE_H

#include "TextureMaterial.h"

class ChequeredBoardMaterial : public TextureMaterial {
public:
    DEV ChequeredBoardMaterial();
    DEV explicit ChequeredBoardMaterial(const Color& color1, const Color& color2);
    DEV MaterialParameter get_texmat(const P3& pos) const final;
    DEV Color get_color(const P3& pos) const final;
    DEV void set_color(int mp, Color& c)
    {
        if (mp == 0)
            mp1.set_color(c);
        else
            mp2.set_color(c);
    }
    DEV void set_diffusion(int mp, float diff)
    {
        if (mp == 0)
            mp1.set_diffusion(diff);
        else
            mp2.set_diffusion(diff);
    }
    DEV void set_specularity(int mp, float spec) {
        if (mp == 0)
            mp1.set_specularity(spec);
        else
            mp2.set_specularity(spec);
    }
    DEV void set_refractivity(int mp, float refrac)
    {
        if (mp == 0)
            mp1.set_refractivity(refrac);
        if (mp == 1)
            mp2.set_refractivity(refrac);
    }
    DEV void set_transparency(int mp, float transp)
    {
        if (mp == 0)
            mp1.set_refractivity(transp);
        if (mp == 1)
            mp2.set_refractivity(transp);
    }

private:
    MaterialParameter mp1;
    MaterialParameter mp2;
};


#endif //RAYTRACER_CHEQUEREDTEXTURE_H
