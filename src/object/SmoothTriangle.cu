#include "SmoothTriangle.h"

DEV V3 SmoothTriangle::normal(const P3 &point) const {
    auto new_normal = (b - a).cross(c - a);
    new_normal = (1 - point.x - point.y) * n1 + point.x * n2 + point.y * n3;
    new_normal.normalize();
    return new_normal;
}
