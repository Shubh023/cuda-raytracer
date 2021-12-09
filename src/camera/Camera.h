//
// Created by shubh on 23/03/2021.
//

#ifndef RAYTRACER_CAMERA_H
#define RAYTRACER_CAMERA_H

#include "math/utils.h"
#include "Ray.h"

class Camera {
public:
    DEV Camera(P3& o, P3& target, V3& _up,
           float _alpha, float _beta, float _zmin);

    /**
     * Getter Functions
     */
    DEV P3 get_origin() { return origin; };
    DEV P3 get_target() { return target; };
    DEV V3 get_up() { return up; };
    // [[nodiscard]] M33 get_camera_matrix() const { return camera_matrix; };
    DEV float get_alpha() const { return alpha; };
    DEV  float get_beta() const { return beta; };
    DEV float get_zmin() const { return zmin; };
    DEV float get_height() const { return height; };
    DEV float get_width() const { return width; };

    /**
     * Setter Functions
     */
    DEV void set_zmin(float _zmin);
    DEV void set_resolution(int _width, int _height);

    /**
     * Calulate ray going from the origin of the camera to the (x, y) point of the camera's "virtual screen"
     * @param x
     * @param y
     * @return Constructed ray
     */
    DEV Ray compute_ray(int x, int y);

    DEV void rotate(float alpha=0.0f, float beta=0.0f, float gamma=0.0f);

protected:
    P3 origin, target;
    V3 up;
    float alpha, beta, zmin, width, height;

    /**
     * M33 CAMERA COORDINATE SYSTEM MATRIX - using FRONT, UP, OTHER
     *
     *   FRONT [ 1 0 0 ]
     *      UP [ 0 1 0 ]
     *   OTHER [ 0 0 1 ]
     */

    V3 matrix[3];
    M33 camera_matrix;
    V3 plane_right, plane_up;
    P3 plane_bottom_left;
};

#endif //RAYTRACER_CAMERA_H
