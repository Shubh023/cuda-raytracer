//
// Created by shubh on 22/03/2021.
//

#ifndef RAYTRACER_MATRIX44_H
#define RAYTRACER_MATRIX44_H

#include "Vector4.h"

class Matrix44
{
public:
    Matrix44() { mat = new V4[4]; }
    Matrix44(int val)
    {
        mat = new V4[4];
        mat[0] += val * Vector4(1,0,0,0);
        mat[1] += val * Vector4(0,1,0,0);
        mat[2] += val * Vector4(0,0,1,0);
        mat[3] += val * Vector4(0,0,0,1);
    }
    Matrix44(Vector4 a, Vector4 b, Vector4 c, Vector4 d)
    {
        mat = new V4[4];
        mat[0] = a;
        mat[1] = b;
        mat[2] = c;
        mat[3] = d;
    };

    /**
     * Setter Function
     */
    void set(V4& a, V4& b, V4& c, V4& d) {mat[0] = a; mat[1] = b; mat[2] = c; mat[3] = d;}
    void set(Matrix44& m) {mat[0] = m[0]; mat[1] = m[1]; mat[2] = m[2]; mat[3] = m[3];}


    /**
     * Matrix44 Destructor
     */
    ~Matrix44() {delete [] mat;};

    /**
     * Mathematical operations on Matrix 44
     */
     double trace() { return mat[0][0] + mat[1][1] + mat[2][2] + mat[3][3]; };
     [[nodiscard]] Matrix44 T() const;
    /**
     * Accessor operator
     */
     Vector4& operator[](int i) const;

     /**
      * Display Matrix 4 x 4
      */
      void print();
protected:
    Vector4* mat;
};

typedef Matrix44 M44;

V4 operator*(const M44& m, const V4& v);
V4 operator*(const V4& v, const M44& m);
M44 operator*(const M44& m1, const M44& m2);
bool operator==(const M44& m1, const M44& m2);
bool operator!=(const M44& m1, const M44& m2);

#endif //RAYTRACER_MATRIX44_H
