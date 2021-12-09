//
// Created by shubh on 23/03/2021.
//

#include "Matrix44.h"

Vector4 &M44::operator[](int i) const {
    switch (i) {
        case 0:
            return mat[0];
        case 1:
            return mat[1];
        case 2:
            return mat[2];
        case 3:
            return mat[3];
        default:
            throw std::out_of_range ("Vector4 index out of bounds");
    }
}

void Matrix44::print() {
    mat[0].print();
    mat[1].print();
    mat[2].print();
    mat[3].print();
}

Matrix44 Matrix44::T() const {
    M44 id(1);
    for (int i = 0; i < 4; i++)
        for (int j = 0; j < 4; j++)
            id[i][j] = mat[j][i];
    return id;
}

V4 operator*(const M44& m, const V4& v)
{

    return Vector4(v.dot(m[0]),
                   v.dot(m[1]),
                   v.dot(m[2]),
                   v.dot(m[3]));
}

V4 operator*(const V4& v, const M44& m)
{
    return Vector4(v.dot(m[0]),
                   v.dot(m[1]),
                   v.dot(m[2]),
                   v.dot(m[3]));
}

M44 operator*(const M44& m1, const M44& m2)
{
    M44 mres(1);
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            mres[i][j] = 0;
            for (int k = 0; k < 4; k++)
                mres[i][j] += m1[i][k] * m2[k][j];
        }
    }
    return mres;
    /*
    auto m2T = m2.T();
    V4 X = m1 * m2T[0];
    V4 Y = m1 * m2T[1];
    V4 Z = m1 * m2T[2];
    V4 W = m1 * m2T[3];
    return M44(X, Y, Z, W).T();
    */
}

bool operator==(const M44& m1, const M44& m2)
{
    return (m1[0] == m2[0]) && (m1[1] == m2[1]) && (m1[2] == m2[2]) && (m1[3] == m2[3]);
}

bool operator!=(const M44& m1, const M44& m2)
{
    return !(m1 != m2);
}
