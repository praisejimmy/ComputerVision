clc

im = imread('bikes1.ppm');
imshow(im);
c = corner_detect(im);
comp = imfuse(c, im);
imshow(comp);