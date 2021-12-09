//
// Created by shubh on 22/03/2021.
//

#ifndef RAYTRACER_VECTOR4_H
#define RAYTRACER_VECTOR4_H


#include <cmath>
#include <iostream>
#include "../Math.h"
#include <stdexcept>

class Vector4 {
public:
    Vector4(): _x(0), _y(0), _z(0), _w(0) {};
    Vector4(double x, double y, double z, double w) : _x(x), _y(y), _z(z), _w(w) {};
    Vector4(const Vector4& u) : _x(u.x()), _y(u.y()), _z(u.z()), _w(u.w()) {};

    /**
     * Getter Functions
     */
    double x() const {return _x;}
    double y() const {return _y;}
    double z() const {return _z;}
    double w() const {return _w;}


    /**
     * Setter Functions
     */
    void set(double x, double y, double z, double w) {_x = x; _y = y; _z = z; _w = w;}
    void set(const Vector4& u) {_x = u.x(); _y = u.y(); _z = u.z(); _w = u.w();}


    /**
     * Math Operations
     */
    double length() const {return _x * _x + _y * _y + _z * _z + _w * _w; }
    double norm() const {return std::sqrt(length()); }
    double dot(Vector4& u) const;
    double operator%(Vector4& u) const;
    Vector4 cross(Vector4& u) const;
    Vector4 operator^(Vector4& u) const;

    /**
     * Display Function
     */
    void print();

    /**
     * Accessor operator
     */
    double &operator[](int i);
    double operator[](int i) const;

protected:
    double _x, _y, _z, _w;
};

typedef Vector4 V4;

/**
  * Display Functions
  */
std::ostream& operator<<(std::ostream &out, Vector4 &u);

/**
 * Enabling basic math operations between Vector4 and doubles
 */
Vector4 operator*(const Vector4& a, double d);
Vector4 operator*(double d, const Vector4& a);
Vector4 operator/(const Vector4& a, double d);
Vector4 operator/(double d, const Vector4& a);
Vector4 operator-(Vector4& a);

/**
 * Enabling operations of type a [ + | - | * | / ] b
 */
Vector4 operator+(const Vector4& a, const Vector4& b);
Vector4 operator-(const Vector4& a, const Vector4& b);
Vector4 operator*(const Vector4& a, const Vector4& b);
Vector4 operator/(const Vector4& a, const Vector4& b);

/**
 * Enabling the assignation of values after operations of type a [ + | - | * | / ]= b
 */
Vector4 operator+=(Vector4& a, const Vector4& b);
Vector4 operator-=(Vector4& a, const Vector4& b);
Vector4 operator*=(Vector4& a, const Vector4& b);
Vector4 operator/=(Vector4& a, const Vector4& b);
Vector4 operator*=(Vector4& a, double d);
Vector4 operator/=(Vector4& a, double d);

/**
 * Enabling Vector4 comparison and validation
 */
bool operator==(const Vector4& a, const Vector4& b);
bool operator!=(const Vector4& a, const Vector4& b);


#endif //RAYTRACER_VECTOR4_H
