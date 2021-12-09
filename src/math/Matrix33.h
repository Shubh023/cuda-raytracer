//
// Created by shubh on 23/03/2021.
//

#ifndef RAYTRACER_MATRIX33_H
#define RAYTRACER_MATRIX33_H

#include "Vector3.h"

class Matrix33
{
public:
    HD Matrix33() {};
    HD Matrix33(int val)
    {
        mat[0] += val * Vector3(1,0,0);
        mat[1] += val * Vector3(0,1,0);
        mat[2] += val * Vector3(0,0,1);
    }
    HD Matrix33(Vector3 a, Vector3 b, Vector3 c)
    {
        mat[0] = a;
        mat[1] = b;
        mat[2] = c;
    };

    /**
     * Setter Function
     */
    HD void set(V3 a, V3 b, V3 c) {mat[0] = a; mat[1] = b; mat[2] = c;}
    HD void set(Matrix33& m) {mat[0] = m[0]; mat[1] = m[1]; mat[2] = m[2];}

    /**
     * Mathematical operations on Matrix 33
     */
    HD double trace() { return mat[0][0] + mat[1][1] + mat[2][2]; };
    HD Matrix33 T();
    /**
     * Accessor operator
     */
    HD Vector3& operator[](int i);
    HD Vector3 operator[](int i) const;

    /**
     * Cleanup Matrix values - Approximate values to a certain floating point precision epsilon
     */
    Matrix33& clean(); //TODO

    /**
    * Apply Rotation using Matrices
    */
    HD Matrix33 Rx(double theta);
    HD Matrix33 Ry(double theta);
    HD Matrix33 Rz(double theta);
    HD Matrix33 rotate(double alpha, double beta, double gamma);
protected:
    Vector3 mat[3];
};

typedef Matrix33 M33;

HD V3 operator*(const M33& m, const V3& v);
HD V3 operator*(const V3& v, const M33& m);
HD M33 operator*(const M33& m1, const M33& m2);
HD bool operator==(const M33& m1, const M33& m2);
HD bool operator!=(const M33& m1, const M33& m2);



#endif //RAYTRACER_MATRIX33_H
