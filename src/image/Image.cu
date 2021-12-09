//
// Created by shubh on 23/03/2021.
//

#include "Image.h"
#include <cassert>
#include <fstream>
#include <stdexcept>


Image::Image(uint _width, uint _height)
{
    height = _height;
    width = _width;
    try {
        pixels = new Color*[height];
        for (int y = 0; y < height; ++y) {
            pixels[y] = new Color[width];
            for (int x = 0; x < width; ++x) {
                pixels[y][x] = Color(float(y) / (height - 1), float(x) / (width - 1), 0.25);
            }
        }
    }
    catch (std::bad_alloc& ba) {
        std::cerr << "RayTracer Error: bad_alloc error (Can't create pixels array) -> " << ba.what() << std::endl;
        assert(false);
    }
}

void Image::save(const std::string& filename) const {
    std::ofstream ofs;
    ofs.open(filename);
    if (ofs.fail())
        throw std::runtime_error ("Can't open output file");
    ofs << "P3\n" << width << " " << height << "\n255\n";
    for (int y = int(height - 1); y >= 0; --y)
    {
        for (int x = 0; x < width; x++) {
            Color col = pixels[y][x];
            int ir = int(255.99 * col[0]);
            int ig = int(255.99 * col[1]);
            int ib = int(255.99 * col[2]);
            ofs << ir << " " << ig << " " << ib << "\n";
        }
    }
    ofs.close();
}

Image::~Image()
{
    if (pixels != nullptr) {
        for (int i = 0; i < height; ++i) {
            delete[] pixels[i];
        }
        delete[] pixels;
        pixels = nullptr;
    }
}
