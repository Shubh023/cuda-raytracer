#include "Point3.h"


HD Point3 operator+(const Point3 &p1, const Point3 &p2)
{
    return Point3(p1.x + p2.x, p1.y + p2.y, p1.z + p2.z);
}

HD Vector3 operator-(const Point3 &p1, const Point3 &p2)
{
    return Vector3(p1.x - p2.x, p1.y - p2.y, p1.z - p2.z);
}

HD Point3 operator*(const Point3 &p, float f)
{
    return Point3(p.x * f, p.y * f, p.z * f);
}

HD Point3 operator*(float f, const Point3 &p)
{
    return Point3(p.x * f, p.y * f, p.z * f);
}

HD Point3 operator/(const Point3 &p, float f)
{
    return Point3(p.x / f, p.y / f, p.z / f);
}


HD Point3 operator+(const Point3 &p, const Vector3 &v)
{
    return Point3(p.x + v.x(), p.y + v.y(), p.z + v.z());
}
HD Point3 operator+(const Vector3 &v, const Point3 &p)
{
    return Point3(p.x + v.x(), p.y + v.y(), p.z + v.z());
}

HD Point3 operator-(const Point3 &p, const Vector3 &v)
{
    return Point3(p.x - v.x(), p.y - v.y(), p.z - v.z());
}
HD Point3 operator-(const Vector3 &v, const Point3 &p)
{
    return Point3(p.x - v.x(), p.y - v.y(), p.z - v.z());
}

HD Point3& operator+=(Point3 &p, const Vector3 &v)
{
    p.x += v.x();
    p.y += v.y();
    p.z += v.z();
    return p;
}
HD Point3& operator-=(Point3 &p, const Vector3 &v)
{
    p.x -= v.x();
    p.y -= v.y();
    p.z -= v.z();
    return p;
}

std::ostream& operator<<(std::ostream &out, const Point3 &p) {
    out << "Point3(" << p.x << ", " << p.y << ", " << p.z << ")";
    return out;
}
