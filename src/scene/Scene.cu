#include "Scene.h"
#include "cuda_runtime.h"

DEV Camera* Scene::get_camera() {
    return camera;
}

DEV void Scene::set_camera(int width, int height) {
    camera->set_resolution(width, height);
}

DEV Color Scene::get_background(Ray&) {
    return Color(0.0, 0.0, 0.0);
}

DEV void Scene::add_object(Object* object) {
    if (maxo > co)
        objects[co++] = object;
    /*
    else
        std::cerr << "Max Objects amount reached" << std::endl;
    */
}

DEV void Scene::add_light(Light* light) {
    if (maxl > cl)
        lights[cl++] = light;
    /*
    else
        std::cerr << "Max Lights amount reached" << std::endl;
        */
}

DEV Object** Scene::get_objects() {
    return objects;
}

DEV Light** Scene::get_lights() {
    return lights;
}
