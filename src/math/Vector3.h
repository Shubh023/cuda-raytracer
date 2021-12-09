//
// Created by shubh on 22/03/2021.
//

#ifndef RAYTRACER_VECTOR3_H
#define RAYTRACER_VECTOR3_H

#include <cmath>
#include <iostream>
#include <stdexcept>
#include "Macros.h"
#include "Math.h"
#include <experimental/optional>

using optional_float = std::experimental::optional<float>;

class Vector3 {
public:
    HD Vector3(): _x(0), _y(0), _z(0) {}
    HD Vector3(float x, float y, float z) : _x(x), _y(y), _z(z) {}
    HD Vector3(const Vector3& u) : _x(u.x()), _y(u.y()), _z(u.z())  {}
    /**
     * Getter Functions
     */
    HD float x() const {return _x;}
    HD float y() const {return _y;}
    HD float z() const {return _z;}

    /**
     * Setter Functions
     */
    HD void set(float x, float y, float z) {_x = x; _y = y; _z = z;}
    HD void set(const Vector3& u) {_x = u.x(); _y = u.y(); _z = u.z();}


    /**
     * Math Operations
     */
    HD float length() const {return _x * _x + _y * _y + _z * _z; }
    HD float norm() const {return std::sqrt(length()); }
    HD Vector3 normalize();
    HD Vector3 normalized() const;
    HD float dot(Vector3 u) const;
    HD float operator%(Vector3 u) const;
    HD Vector3 cross(Vector3 u) const;
    HD Vector3 operator^(Vector3 u) const;


    /**
      * Display Function
      */
      void print() const;

     /**
      * Accesor operator
      */
    HD float &operator[](int i);
    //HD float operator[](int i);

    float _x, _y, _z;

    //friend struct Point3;
};

typedef Vector3 V3;

/**
  * Display Functions
  */
std::ostream& operator<<(std::ostream &out, Vector3 &u);

/**
 * Enabling basic math operations between Vector3 and floats
 */
HD Vector3 operator*(const Vector3& a, float d);
HD Vector3 operator*(float d, const Vector3& a);
HD Vector3 operator/(const Vector3& a, float d);
HD Vector3 operator/(float d, const Vector3& a);
HD Vector3 operator-(Vector3& a);

/**
 * Enabling operations of type a [ + | - | * | / ] b
 */
HD Vector3 operator+(const Vector3& a, const Vector3& b);
HD Vector3 operator-(const Vector3& a, const Vector3& b);
HD Vector3 operator*(const Vector3& a, const Vector3& b);

HD Vector3 operator/(const Vector3& a, const Vector3& b);

/**
 * Enabling the assignation of values after operations of type a [ + | - | * | / ]= b
 */
HD Vector3& operator+=(Vector3& a, const Vector3& b);
HD Vector3& operator-=(Vector3& a, const Vector3& b);
HD Vector3& operator*=(Vector3& a, const Vector3& b);
HD Vector3& operator/=(Vector3& a, const Vector3& b);
HD Vector3& operator*=(Vector3& a, float d);
HD Vector3& operator/=(Vector3& a, float d);

/**
 * Enabling Vector3 comparison and validation
 */
HD bool operator==(const Vector3& a, const Vector3& b);
HD bool operator!=(const Vector3& a, const Vector3& b);

#endif //RAYTRACER_VECTOR3_H
