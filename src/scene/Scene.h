#pragma once

#include <vector>
#include <memory>
#include "object/Object.h"
#include "light/Light.h"
#include "../camera/Ray.h"
#include "camera/Camera.h"
#include "../image/Color.h"

class Scene {
public:
    DEV Scene(Camera* cam, int max_object, int max_light): camera(cam) {

        maxo = max_object;
        maxl = max_light;
        objects = new Object*[max_object];
        lights = new Light*[max_light];
    }

    /**
     * Getter Functions
     */
    DEV Camera* get_camera();
    DEV static Color get_background(Ray &ray);
    DEV Object** get_objects();
    DEV Light** get_lights();
    DEV int get_maxo() {return maxo;}
    DEV int get_maxl() {return maxl;}
    DEV int get_co() {return co;}
    DEV int get_cl() {return cl;}

   // DEV Scene* cuda_scene();

    /**
     * Setter Functions
     */
    DEV void set_camera(int width, int height);
    DEV void add_object(Object* object);
    DEV void add_light(Light* light);


protected:
    Camera* camera;
    int co, cl, maxo, maxl;
    Object** objects;
    Light** lights;
};

