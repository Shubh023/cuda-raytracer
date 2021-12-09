#include "Triangle.h"

#define DOUBLE_EPSILON 1e-9
#define ABS_MIN 1e-9

// Handle floatequality comparison
DEV bool approximatelyEqual(float a, float b)
{
  if (a == b) return true;

  auto diff = std::abs(a-b);
  auto norm = std::min(std::abs(a + b), std::numeric_limits<float>::max());
  return diff < std::max(ABS_MIN, DOUBLE_EPSILON * norm);
}

DEV Triangle::Triangle(Point3 _a, Point3 _b, Point3 _c)
:a(_a), b(_b), c(_c) {
    AB = b - a;
    AC = c - a;
}

DEV float Triangle::intersect(const Ray& ray) {
    float det, inv_det;

    Vector3 p = ray.direction ^ AC;
    det = AB % p;

    if (approximatelyEqual(det, 0)) // Ray misses the plane
        return -1;

    inv_det = 1 / det;
    Vector3 OA = ray.origin - a;
    float u = (OA % p) * inv_det;
    if (u < 0.0 || u > 1.0)
        return -1;

    Vector3 q = OA ^ AB;
    float v = (ray.direction % q) * inv_det;
    if (v < 0.0 || u + v > 1.0)
        return -1;

    float t = (AC % q) * inv_det;
    return t;
}

DEV bool Triangle::bool_intersect(const Ray& ray) {
    float det, inv_det;

    Vector3 p = ray.direction ^ AC;
    det = AB % p;

    if (approximatelyEqual(det, 0))
        return false;
    if (det < 0) // Backface hit do not hide light
        return false;

    inv_det = 1 / det;
    Vector3 OA = ray.origin - a;
    float u = (OA % p) * inv_det;
    if (u < 0.0 || u > 1.0)
        return false;

    Vector3 q = OA ^ AB;
    float v = (ray.direction % q) * inv_det;
    if (v < 0.0 || u + v > 1.0)
        return false;

    return true;
}


DEV Vector3 Triangle::normal(const Point3& p) const {
    return (AB ^ AC).normalize();
}

DEV MaterialParameter Triangle::get_param_at(const P3 &point) const {
    return texmat->get_texmat(point);
}

DEV Color Triangle::get_color(const P3 &point) const {
    return texmat->get_color(point);
}
