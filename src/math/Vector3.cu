//
// Created by shubh on 23/03/2021.
//

#include "Vector3.h"
#include "../Macros.h"
#include <iostream>
#include <err.h>
#include <stdio.h>
/**
 * Basic Accessor & useful operators
 */
HD float& Vector3::operator[](int i)  {
    switch (i) {
        case 0:
            return _x;
        case 1:
            return _y;
        case 2:
            return _z;
        default:
            printf("Vector3 index out of bounds");
    }
    return _x;
}
/*
HD float &Vector3::operator[](int i) {
    switch (i) {
        case 0:
            return _x;
        case 1:
            return _y;
        case 2:
            return _z;
        default:
            warnx("Vector3 index out of bounds");
    }
    return 1;
}
*/


/**
  * Display Functions
  */

void Vector3::print() const {
    std::cout << "{ " << _x << ", " << _y << ", " << _z << " }" << std::endl;
}

std::ostream& operator<<(std::ostream &out, Vector3 &u)
{
    out << "{ " << u.x() << ", " << u.y() << ", " << u.z() << " }";
    return out;
}


/**
 * Enabling basic math operations between Vector3 and floats
 */


HD Vector3 operator*(const Vector3& a, const float d)
{
    return Vector3(a.x() * d, a.y() * d, a.z() * d);
}

HD Vector3 operator*(const float d, const Vector3& a)
{
    return Vector3(a.x() * d, a.y() * d, a.z() * d);
}

HD Vector3 operator/(const Vector3& a, const float d)
{
    return Vector3(a.x() / d, a.y() / d, a.z() / d);
}

HD Vector3 operator/(const float d, const Vector3& a)
{
    return Vector3(d / a.x(), d / a.y(), d / a.z());
}

HD Vector3 operator-(Vector3& a)
{
    return -1 * a;
}

/**
 * Enabling operations of type a [ + | - | * | / ] b
 */

HD Vector3 operator+(const Vector3& a, const Vector3& b)
{
    return Vector3(a.x() + b.x(), a.y() + b.y(), a.z() + b.z());
}

HD Vector3 operator-(const Vector3& a, const Vector3& b)
{
    return Vector3(a.x() - b.x(), a.y() - b.y(), a.z() - b.z());
}

HD Vector3 operator*(const Vector3& a, const Vector3& b)
{
    return Vector3(a.x() * b.x(), a.y() * b.y(), a.z() * b.z());
}

HD Vector3 operator/(const Vector3& a, const Vector3& b)
{
    return Vector3(a.x() / b.x(), a.y() / b.y(), a.z() / b.z());
}


/**
 * Enabling the assignation of values after operations of type a [ + | - | * | / ]= b
 */

HD Vector3& operator+=(Vector3& a, const Vector3& b)
{
    a.set(a.x() + b.x(), a.y() + b.y(), a.z() + b.z());
    return a;
}

HD Vector3& operator-=(Vector3& a, const Vector3& b)
{
    a.set(a.x() - b.x(), a.y() - b.y(), a.z() - b.z());
    return a;
}

HD Vector3& operator*=(Vector3& a, const Vector3& b)
{
    a.set(a.x() * b.x(), a.y() * b.y(), a.z() * b.z());
    return a;
}

HD Vector3& operator/=(Vector3& a, const Vector3& b)
{
    a.set(a.x() / b.x(), a.y() / b.y(), a.z() / b.z());
    return a;
}

HD Vector3& operator*=(Vector3& a, const float d)
{
    a.set(a.x() * d, a.y() * d, a.z() * d);
    return a;
}

HD Vector3& operator/=(Vector3& a, const float d)
{
    a.set(a.x() / d, a.y() / d, a.z() / d);
    return a;
}

/**
 * Classic Operations between Vector3 a and b
 */
HD float Vector3::dot(Vector3 u) const {
    return _x * u.x() + _y * u.y() + _z * u.z();
}

HD float Vector3::operator%(Vector3 u) const {
    return this->dot(u);
}

HD Vector3 Vector3::cross(Vector3 u) const {
    return Vector3(_y * u.z() - _z * u.y(),
                   _z * u.x() - _x * u.z(),
                   _x * u.y() - _y * u.x());
}

HD Vector3 Vector3::operator^(Vector3 u) const {
    return this->cross(u);
}

HD Vector3 Vector3::normalized() const {
    return *this / this->norm();
}

HD Vector3 Vector3::normalize() {
    this->set(*this / this->norm());
    return *this;
}

/*HD inline  Vector3 &Vector3::clamp(float min, float max) {
    auto x = std::max(std::min(float(_x), max), min);
    auto y = std::max(std::min(float(_y), max), min);
    auto z = std::max(std::min(float(_z), max), min);
    set(x,y,z);
    return *this;
}
 */


/**
 * Enabling Vector3 comparison and validation
 */

HD  bool operator==(const Vector3& a, const Vector3& b)
{
    return approximatelyeq(a._x, b._x) &&
           approximatelyeq(a._y, b._y) &&
           approximatelyeq(a._z, b._z);
}

HD  bool operator!=(const Vector3& a, const Vector3& b)
{
    return !(a == b);
}
