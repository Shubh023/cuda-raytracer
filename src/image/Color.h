//
// Created by shubh on 23/03/2021.
//

#ifndef RAYTRACER_COLOR_H
#define RAYTRACER_COLOR_H

#include <iostream>
#include "math/Vector3.h"

using optional_float = std::experimental::optional<float>;


class Color {
public:
    HD Color() : _r(0), _g(0), _b(0) {};
    HD Color(float r, float g, float b) : _r(r), _g(g), _b(b) {};
    HD Color(Color& c) : _r(c._r), _g(c._g), _b(c._b) {};
    HD Color(const Color& c) : _r(c._r), _g(c._g), _b(c._b) {};
    HD explicit Color(V3 v) : _r(v.x()), _g(v.y()), _b(v.z()) {};

    /**
     * Getter Functions
     */
    HD  float r() const { return _r; };
    HD float g() const { return _g; };
    HD  float b() const { return _b; };

    /**
     * Setter Functions
     */
    HD void set(float r, float g, float b) {_r = r; _g = g; _b = b;};
    HD  void set(Color& c) {_r = c.r(); _g = c.g(); _b = c.b();};

     /**
      * Accessor Operator
      */
    // HD  float &operator[](int i);
    HD float operator[](int i) const;

    /**
    * Display Functions
    */
    void print() const;

    /**
     * Utils
     */
    HD  V3 to_v3() const { return V3(_r, _g, _b);}
    HD  Color& clamp(float min=0.0, float max=1.0);

protected:
    float _r, _g, _b;
};

/**
  * Display Functions
  */
std::ostream& operator<<(std::ostream &out, Color &c);


class RGB {
public:
    RGB() : _r(0), _g(0), _b(0) {};
    RGB(uint8_t r, uint8_t g, uint8_t b) : _r(r), _g(g), _b(b) {};
    RGB(RGB& c) : _r(c.r()), _g(c.g()), _b(c.b()) {};

    /**
     * Getter Functions
     */
    [[nodiscard]] uint8_t r() const { return _r; };
    [[nodiscard]] uint8_t g() const { return _g; };
    [[nodiscard]] uint8_t b() const { return _b; };

    /**
     * Setter Functions
     */
    void set(uint8_t r, uint8_t g, uint8_t b) {_r = r; _g = g; _b = b;};
    void set(RGB& c) {_r = c.r(); _g = c.g(); _b = c.b();};

    /**
     * Accessor Operator
     */
    uint8_t &operator[](int i);
    uint8_t operator[](int i) const;

    /**
     * Display Functions
     */
     void print() const;

protected:
    uint8_t _r, _g, _b;
};

/**
  * Display Functions
  */
std::ostream& operator<<(std::ostream &out, RGB &c);


/**
 * Math Operations on Colors
 */

HD Color operator+(const Color& c1, const Color& c2);
HD Color operator-(const Color& c1, const Color& c2);
HD Color operator*(const Color& c1, const Color& c2);
HD Color operator*(const Color& c1, float f);
HD Color operator*(float f, const Color& c1);
HD Color operator/(const Color& c1, float f);
HD Color operator/(float f, const Color& c1);

HD Color& operator+=(Color& c1, const Color& c2);
HD Color& operator-=(Color& c1, const Color& c2);
HD Color& operator*=(Color& c, float f);
HD Color& operator/=(Color& c, float f);
HD Color& operator*=(Color& c1, const Color& c2);

#endif //RAYTRACER_COLOR_H
