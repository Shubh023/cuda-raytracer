//
// Created by shubh on 23/03/2021.
//

#include "Vector4.h"

/**
 * Basic Accessor & useful operators
 */
double Vector4::operator[](int i) const {
    switch (i) {
        case 0:
            return _x;
        case 1:
            return _y;
        case 2:
            return _z;
        case 3:
            return _w;
        default:
            throw std::out_of_range ("Vector4 index out of bounds");
    }
}

double &Vector4::operator[](int i) {
    switch (i) {
        case 0:
            return _x;
        case 1:
            return _y;
        case 2:
            return _z;
        case 3:
            return _w;
        default:
            throw std::out_of_range ("Vector4 index out of bounds");
    }
}

/**
  * Display Functions
  */

void Vector4::print() {
    std::cout << "{ " << _x << ", " << _y << ", " << _z << ", " << _w << " }" << std::endl;
}

std::ostream& operator<<(std::ostream &out, Vector4 &u)
{
    out << "{ " << u.x() << ", " << u.y() << ", " << u.z() << ", " << u.w() << " }";
    return out;
}

/**
 * Classic Operations between Vector4 a and b
 */
double Vector4::dot(Vector4 &u) const {
    return _x * u.x() + _y * u.y() + _z * u.z() + _w * u.w();
}

double Vector4::operator%(Vector4 &u) const {
    return this->dot(u);
}

Vector4 Vector4::cross(Vector4 &u) const {
    return Vector4(_x * u.x() - _y * u.y() - _z * u.z() - _w * u.w(),
                   _y * u.x() + _x * u.y() - _w * u.z() + _z * u.w(),
                   _z * u.x() + _w * u.y() + _x * u.z() - _y * u.w(),
                   _w * u.x() - _z * u.y() + _y * u.z() + _x * u.w());
}

Vector4 Vector4::operator^(Vector4 &u) const {
    return this->cross(u);
}




/**
 * Enabling basic math operations between Vector4 and doubles
 */

Vector4 operator*(const Vector4& a, const double d)
{
    return Vector4(a.x() * d, a.y() * d, a.z() * d, a.w() * d);
}

Vector4 operator*(const double d, const Vector4& a)
{
    return Vector4(a.x() * d, a.y() * d, a.z() * d, a.w() * d);
}

Vector4 operator/(const Vector4& a, const double d)
{
    return Vector4(a.x() / d, a.y() / d, a.z() / d, a.w() / d);
}

Vector4 operator/(const double d, const Vector4& a)
{
    return Vector4(d / a.x(), d / a.y(), d / a.z(), d / a.w());
}

Vector4 operator-(Vector4& a)
{
    return -1 * a;
}

/**
 * Enabling operations of type a [ + | - | * | / ] b
 */

Vector4 operator+(const Vector4& a, const Vector4& b)
{
    return Vector4(a.x() + b.x(), a.y() + b.y(), a.z() + b.z(), a.w() + b.w());
}

Vector4 operator-(const Vector4& a, const Vector4& b)
{
    return Vector4(a.x() - b.x(), a.y() - b.y(), a.z() - b.z(), a.w() - b.w());
}

Vector4 operator*(const Vector4& a, const Vector4& b)
{
    return Vector4(a.x() * b.x(), a.y() * b.y(), a.z() * b.z(), a.w() * b.w());
}

Vector4 operator/(const Vector4& a, const Vector4& b)
{
    return Vector4(a.x() / b.x(), a.y() / b.y(), a.z() / b.z(), a.w() / b.w());
}


/**
 * Enabling the assignation of values after operations of type a [ + | - | * | / ]= b
 */

Vector4 operator+=(Vector4& a, const Vector4& b)
{
    a.set(a.x() + b.x(), a.y() + b.y(), a.z() + b.z(), a.w() + b.w());
    return a;
}

Vector4 operator-=(Vector4& a, const Vector4& b)
{
    a.set(a.x() - b.x(), a.y() - b.y(), a.z() - b.z(), a.w() - b.w());
    return a;
}

Vector4 operator*=(Vector4& a, const Vector4& b)
{
    a.set(a.x() * b.x(), a.y() * b.y(), a.z() * b.z(),  a.w() * b.w());
    return a;
}

Vector4 operator/=(Vector4& a, const Vector4& b)
{
    a.set(a.x() / b.x(), a.y() / b.y(), a.z() / b.z(),  a.w() / b.w());
    return a;
}

Vector4 operator*=(Vector4& a, const double d)
{
    a.set(a.x() * d, a.y() * d, a.z() * d, a.w() * d);
    return a;
}

Vector4 operator/=(Vector4& a, const double d)
{
    a.set(a.x() / d, a.y() / d, a.z() / d, a.w() / d);
    return a;
}

/**
 * Enabling Vector4 comparison and validation
 */

bool operator==(const Vector4& a, const Vector4& b)
{
    return approximatelyeq(a[0], b[0]) &&
           approximatelyeq(a[1], b[1]) &&
           approximatelyeq(a[2], b[2]) &&
           approximatelyeq(a[3], b[3]);
}

bool operator!=(const Vector4& a, const Vector4& b)
{
    return !(a == b);
}