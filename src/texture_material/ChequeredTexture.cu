//
// Created by shubh on 25/03/2021.
//

#include "ChequeredTexture.h"

DEV ChequeredBoardMaterial::ChequeredBoardMaterial(const Color& color1, const Color& color2) : mp1(color1), mp2(color2)
{}

DEV ChequeredBoardMaterial::ChequeredBoardMaterial() : ChequeredBoardMaterial(Color(0.0, 0.0, 0.0), Color(1, 1, 1))
{}

#define Mult 1
#define Add 20.0

DEV MaterialParameter ChequeredBoardMaterial::get_texmat(const P3& pos) const {
    if ((int((pos.x + Add) * Mult) % 2) == (int((pos.y + Add) * Mult) % 2) ==(int((pos.z + Add) * Mult) % 2))
        return mp1;
    return mp2;
}

DEV Color ChequeredBoardMaterial::get_color(const P3 &pos) const {
    if ((int((pos.x + Add) * Mult) % 2) == (int((pos.y + Add) * Mult) % 2) ==(int((pos.z + Add) * Mult) % 2))
        return mp1.color;
    return mp2.color;
}
