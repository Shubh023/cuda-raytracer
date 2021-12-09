//
// Created by shubh on 23/03/2021.
//

#include "Camera.h"

DEV Camera::Camera(P3 &_origin, P3 &_target, V3 &_up, float _alpha, float _beta, float _zmin) {

    /** Setting up Camera related Vectors **/
    origin = _origin;
    target = _target;
    up = _up;
    V3 front = (target - origin).normalized();
    V3 other = up.cross(front).normalized();

    /** Setting up Camera Coordinate System using Camera related Vectors **/
    // camera_matrix[0] = front.normalized();
    // camera_matrix[1] = up.normalized();
    // camera_matrix[2] = other.normalized();
    camera_matrix = M33(up,up,up);
    camera_matrix.set(front.normalized(), up.normalized(), other.normalized());
    zmin = _zmin;
    alpha = _alpha;
    beta = _beta;
    set_resolution(1920, 1080);
}

DEV void Camera::set_zmin(float _zmin) {
    zmin = _zmin;
}

DEV void Camera::set_resolution(int _width, int _height) {
    width = _width;
    height = _height;
    float real_width = std::tan(alpha / 2) * zmin;
    float real_height = std::tan(beta / 2) * zmin;

    plane_up = camera_matrix[1] * (2 * real_height / (_height - 1));
    plane_right = camera_matrix[2] * (2 * real_width / (_width - 1));
    plane_bottom_left = origin + (camera_matrix[0] * zmin) // Go to image plane
                        - (camera_matrix[1] * real_height) // Go to bottom border
                        - (camera_matrix[2] * real_width); // Go to left border
}

DEV Ray Camera::compute_ray(int x, int y) {
    Point3 pixel = plane_bottom_left + (x * plane_up) + (y * plane_right);
    Ray ray(origin, (pixel - origin).normalized());
    return ray;
}

DEV void Camera::rotate(float alpha, float beta, float gamma) {
    M33 rotation_matrix = camera_matrix.rotate(gamma, beta, alpha);
    camera_matrix = rotation_matrix * camera_matrix;
}
