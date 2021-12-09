//
// Created by shubh on 23/03/2021.
//

#ifndef RAYTRACER_IMAGE_H
#define RAYTRACER_IMAGE_H

#include <iostream>
#include "Color.h"

class Image {
public:
    /**
     * Image Constructors
     */
    Image() =default;
    Image(uint _width, uint _height);

    /**
    * Image Destructor
    */
    ~Image();

    /**
     * Getter Functions
     */
    [[nodiscard]] uint w() const { return width; };
    [[nodiscard]] uint h() const { return height; };
    [[nodiscard]] Color& get_pixel(uint i, uint j) const { return pixels[i][j];};


    /**
     * Setter Functions
     */
    void set_width(uint _width) { width = _width; };
    void set_height(uint _height) { height = _height; };
    // void set_pixel(uint i, Color color) {};
    void set_pixel(uint i, uint j,  Color color) const { pixels[i][j].set(color); };

    /**
     * Save Image as a PPM format file
     * @param filename
     */
    void save(const std::string& filename) const;

    Color** pixels{};
protected:
    uint width;
    uint height;
};



#endif //RAYTRACER_IMAGE_H
