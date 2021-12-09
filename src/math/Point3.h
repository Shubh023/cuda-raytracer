#pragma once

#include <iostream>
#include "../Macros.h"
#include "Vector3.h"

struct Point3 {
    float x, y, z;

    HD Point3(): Point3(0, 0, 0)
    {}
    HD Point3(Vector3& v): Point3(v.x(), v.y(), v.z()) {};
    HD Point3(float _x, float _y, float _z): x(_x), y(_y), z(_z)
    {}
};

typedef Point3 P3;

HD Point3 operator+(const Point3 &p1, const Point3 &p2);
HD Vector3 operator-(const Point3 &p1, const Point3 &p2);
HD Point3 operator*(const Point3 &p, float f);
HD Point3 operator*(float f, const Point3 &p);
HD Point3 operator/(const Point3 &p, float f);

HD Point3 operator+(const Point3 &p, const Vector3 &v);
HD Point3 operator+(const Vector3 &v, const Point3 &p);

HD Point3 operator-(const Point3 &p, const Vector3 &v);
HD Point3 operator-(const Vector3 &v, const Point3 &p);

HD Point3& operator+=(Point3 &p, const Vector3 &v);
HD Point3& operator-=(Point3 &p, const Vector3 &v);

std::ostream& operator<<(std::ostream &out, const Point3 &p);