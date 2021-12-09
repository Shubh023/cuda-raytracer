//
// Created by shubh on 4/5/21.
//

#ifndef RAYTRACER_MACROS_H
#define RAYTRACER_MACROS_H

#define HD __host__ __device__
#define HST __host__
#define DEV __device__
#define GBL __global__

#define checkCudaErrors(val) check_cud( (val), #val, __FILE__, __LINE__ )


void check_cud(cudaError_t result, char const *const func, const char *const file, int const line);

#endif //RAYTRACER_MACROS_H
