//
// Created by shubh on 23/03/2021.
//

#include "Color.h"
#include <err.h>
#include <stdio.h>
/** METHODS for Color class **/

HD Color& Color::clamp(float min, float max) {
    auto r = std::max(std::min(float(_r), max), min);
    auto g = std::max(std::min(float(_g), max), min);
    auto b = std::max(std::min(float(_b), max), min);
    set(r,g,b);
    return *this;
}

HD float Color::operator[](int i) const {
    switch (i) {
        case 0:
            return _r;
        case 1:
            return _g;
        case 2:
            return _b;
        default:
            printf("Color index out of bounds");
            return {};
    }
    return {};
}

/*
HD float &Color::operator[](int i) {
    switch (i) {
        case 0:
            return _r;
        case 1:
            return _g;
        case 2:
            return _b;
        default:
            throw std::out_of_range ("Color index out of bounds");
    }
}
*/
void Color::print() const {
    std::cout << "{ " << _r << ", " << _g << ", " << _b << " }" << std::endl;
}


std::ostream& operator<<(std::ostream &out, Color &c)
{
    out << "{ " << c.r() << ", " << c.g() << ", " << c.b() << " }";
    return out;
}


/** METHODS for RGB class **/
uint8_t RGB::operator[](int i) const {
    switch (i) {
        case 0:
            return _r;
        case 1:
            return _g;
        case 2:
            return _b;
        default:
            throw std::out_of_range ("Color index out of bounds");
    }
}

uint8_t &RGB::operator[](int i) {
    switch (i) {
        case 0:
            return _r;
        case 1:
            return _g;
        case 2:
            return _b;
        default:
            throw std::out_of_range ("Color index out of bounds");
    }
}

void RGB::print() const {
    std::cout << "{ " << _r << ", " << _g << ", " << _b << " }" << std::endl;
}


std::ostream& operator<<(std::ostream &out, RGB &c)
{
    out << "{ " << c.r() << ", " << c.g() << ", " << c.b() << " }";
    return out;
}

HD Color operator+(const Color& c1, const Color& c2) {
    return Color(c1.r() + c2.r(), c1.g() + c2.g(), c1.b() + c2.b());
}

HD Color operator*(const Color& c1, const Color& c2) {
    return Color(c1.r() * c2.r(), c1.g() * c2.g(), c1.b() * c2.b());
}

HD Color operator-(const Color& c1, const Color& c2) {
    return Color(c1.r() - c2.r(), c1.g() - c2.g(), c1.b() - c2.b());
}

HD Color operator*(const Color& c, float f) {
    return Color(c.r() * f, c.g() * f, c.b() * f);
}

HD Color operator*(float f, const Color& c) {
    return Color(c.r() * f, c.g() * f, c.b() * f);
}

HD Color operator/(const Color& c, float f) {
    return Color(c.r() / f, c.g() / f, c.b() / f);
}

HD Color operator/(float f, const Color& c) {
    return Color(c.r() / f, c.g() / f, c.b() / f);
}

HD Color& operator+=(Color& c1, const Color& c2) {
    c1.set(c1.r() + c2.r(), c1.g() + c2.g(), c1.b() + c2.b());
    return c1;
}

HD Color& operator-=(Color& c1, const Color& c2) {
    c1.set(c1.r() - c2.r(), c1.g() - c2.g(), c1.b() - c2.b());
    return c1;
}

HD Color& operator*=(Color& c, float f) {
    c.set(c.r() * f, c.g() * f, c.b() * f);
    return c;
}

HD Color& operator/=(Color& c, float f) {
    c.set(c.r() / f, c.g() / f, c.b() / f);
    return c;
}

HD Color& operator*=(Color& c1, const Color& c2) {
    c1.set(c1.r() * c2.r(), c1.g() * c2.g(), c1.b() * c2.b());
    return c1;
}
