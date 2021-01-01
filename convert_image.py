#!/usr/bin/env python3
from PIL import Image
import numpy as np

arr = bytearray()
width = 640
height = 480

with Image.open ("panda.jpg", "r") as file:
    pixels = file.load()

    for i in range (height):
        for j in range (width):
            red = pixels[j, i][0]
            green = pixels[j, i][1]
            blue = pixels[j, i][2]
            alpha = 255

            color = (red << 24) | (green << 16) |  (blue << 8) | alpha

            arr.append((color >> 24))
            arr.append((color >> 16) & 0xFF)
            arr.append((color >> 8) & 0xFF)
            arr.append(color & 0xFF)

    with open ("panda.bin", "wb") as output:
        output.write(arr)
