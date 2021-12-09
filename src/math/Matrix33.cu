//
// Created by shubh on 23/03/2021.
//

#include "Matrix33.h"
#include <err.h>
#include <stdio.h>

HD Vector3 M33::operator[](int i) const {
    switch (i) {
        case 0:
            return mat[0];
        case 1:
            return mat[1];
        case 2:
            return mat[2];
        default:
            printf("Matrix33 index out of bounds");
    }
    return mat[0];
}

HD Vector3 &Matrix33::operator[](int i) {
    switch (i) {
        case 0:
            return mat[0];
        case 1:
            return mat[1];
        case 2:
            return mat[2];
        default:
            printf("Matrix33 index out of bounds");
    };
    return mat[0];
}


HD Matrix33 Matrix33::T() {
    M33 id(1);
    for (int i = 0; i < 3; i++)
        for (int j = 0; j < 3; j++)
            id[i][j] = mat[j][i];
    return id;
}

HD V3 operator*(const M33& m, const V3& v)
{
    auto v0 = m[0];
    auto v1 = m[1];
    auto v2 = m[2];
    return Vector3(v.dot(v0),
                   v.dot(v1),
                   v.dot(v2));
}

HD V3 operator*(const V3& v, const M33& m)
{
    auto v0 = m[0];
    auto v1 = m[1];
    auto v2 = m[2];
    return Vector3(v.dot(v0),
                   v.dot(v1),
                   v.dot(v2));
}

HD M33 operator*(const M33& m1, const M33& m2)
{
    M33 mres(1);
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            mres[i][j] = 0;
            for (int k = 0; k < 3; k++)
                mres[i][j] += m1[i][k] * m2[k][j];
        }
    }
    return mres;
    /*
    auto m2T = m2.T();
    V3 X = m1 * m2T[0];
    V3 Y = m1 * m2T[1];
    V3 Z = m1 * m2T[2];
    V3 W = m1 * m2T[3];
    return M33(X, Y, Z, W).T();
    */
}

HD bool operator==(const M33& m1, const M33& m2)
{
    return (m1[0] == m2[0]) && (m1[1] == m2[1]) && (m1[2] == m2[2]);
}

HD bool operator!=(const M33& m1, const M33& m2)
{
    return !(m1 == m2);
}

/**
 * Rotation Matrices
 */

HD M33 Matrix33::Rx(double theta)
{
    return M33(V3(1,0,0).normalized(),
               V3(0, cos(theta), -sin(theta)).normalized(),
               V3(0, sin(theta), cos(theta)).normalized());
}

HD M33 Matrix33::Ry(double theta)
{
    return M33(V3( cos(theta), 0, sin(theta)).normalized(),
               V3(0, 1,0).normalized(),
               V3(-sin(theta), 0, cos(theta)).normalized());
}

HD M33 Matrix33::Rz(double theta)
{
    return M33(V3( cos(theta), -sin(theta), 0).normalized(),
               V3(sin(theta), cos(theta), 0).normalized(),
               V3(0, 0,1).normalized());
}

HD M33 Matrix33::rotate(double alpha, double beta, double gamma)
{
    /**
     * alpha -> rotate around X axis
     * beta -> rotate around Y axis
     * gamma -> rotate around Z axis
     */
    return Rz(gamma) * Ry(beta) * Rx(alpha);
}

