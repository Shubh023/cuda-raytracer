//
// Created by shubh on 09/04/2021.
//

#pragma once
#include "Object.h"
#include "Triangle.h"

class SmoothTriangle : public Triangle
{
public:
    DEV SmoothTriangle(P3 a, P3 b, P3 c, V3 _n1, V3 _n2, V3 _n3) : Triangle(a,b,c), n1(_n1), n2(_n2), n3(_n3) {};
    DEV V3 normal(const P3& point) const override;

    V3 n1;
    V3 n2;
    V3 n3;
};