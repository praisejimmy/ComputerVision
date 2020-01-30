clc

im = imread('Boat2.tif');
figure(1);
imshow('Boat2.tif');

filtered = median_filter(im, 3);
figure(2);
imshow(filtered);

im = imread('building.gif');

figure(4);imshow(im);
filtered = gaussian_filter(im, 2, 5);
figure(5);imshow(filtered);
