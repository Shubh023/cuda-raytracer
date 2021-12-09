cmake_minimum_required(VERSION 3.17)
set(CMAKE_CUDA_COMPILER /usr/local/cuda-11.2/bin/nvcc)
set(CMAKE_CUDA_HOST_COMPILER  /usr/bin/g++)
project(raytracer LANGUAGES CXX CUDA)
set(CMAKE_CXX_STANDARD 17)

set(CMAKE_CUDA_COMPILE_FEATURES "--expt-relaxed-constexpr --expt-extended-lambda")
set(CMAKE_CUDA_FLAGS "--expt-relaxed-constexpr --expt-extended-lambda")
set(CMAKE_CUDA_FLAGS_DEBUG "-G -g")

set(CMAKE_CXX_FLAGS "-Wall -Werror -Wextra -pedantic")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fno-omit-frame-pointer -fsanitize=address")
set(CMAKE_LINKER_FLAGS_DEBUG "${CMAKE_LINKER_FLAGS_DEBUG} -fno-omit-frame-pointer -fsanitize=address")
set(INCLUDE_DIRECTORIES "${INCLUDE_DIRECTORIES} src")
set(CMAKE_CUDA_ARCHITECTURES 86)
include_directories(raytrace src)

# RAYTRACER EXECUTABLE CONFIG
set(MATH_CPP_FILES src/math/Math.cu src/math/Vector3.cu src/math/Point3.cu src/math/Matrix33.cu)
set(MATH_FILES ${MATH_HH_FILES} ${MATH_CPP_FILES})

set(IMAGE_FILES src/image/Image.cu src/image/Image.h src/image/Color.cu src/image/Color.h)

set(CAMERA_FILES src/camera/Camera.cu src/camera/Ray.cu src/camera/Camera.h src/camera/Ray.h)

set(SCENE_FILES src/scene/Scene.cu src/scene/Scene.h)

set(ENGINE_FILES src/engine/Engine.cu src/engine/Engine.h)

set(OBJECT_FILES src/object/Object.h src/object/Object.cu src/object/Sphere.cu src/object/Sphere.h src/object/Plane.cu src/object/Plane.h src/object/Triangle.cu src/object/Triangle.h src/object/SmoothTriangle.h src/object/SmoothTriangle.cu src/object/Box.h src/object/Box.cu src/object/Blob.h src/object/Blob.cu)

set(TEXMAT_FILES src/texture_material src/texture_material/TextureMaterial.h src/texture_material/UniformTexture.h src/texture_material/UniformTexture.cu src/texture_material/texture_material.h src/texture_material/ChequeredTexture.cu src/texture_material/ChequeredTexture.h src/texture_material/UVTexture.h src/texture_material/UVTexture.cu src/texture_material/ParametricTexture.h src/texture_material/ParametricTexture.cu)

set(LIGHT_FILES src/light/Light.h src/light/PointLight.cu src/light/PointLight.h src/light/Light.cu src/light/DirectionalLight.cu src/light/DirectionalLight.h src/light/SpotLight.cu src/light/SpotLight.h)


set(FILES ${MATH_FILES} ${IMAGE_FILES} ${CAMERA_FILES} ${SCENE_FILES} ${ENGINE_FILES} ${OBJECT_FILES} ${TEXMAT_FILES} ${LIGHT_FILES})
add_executable(raytracer src/main.cu ${FILES})
target_link_libraries(raytracer)
set_target_properties(
        raytracer
        PROPERTIES
        CUDA_STANDARD 17
        CUDA_SEPARABLE_COMPILATION ON)
