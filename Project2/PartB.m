clc, clear all; 
close all;

im = imread('corridor.jpg');

figure(1);
imshow(im);

figure(2);
imshow(prewitt_filter(im));

figure(3);
imshow(sobel_filter(im));

%Varying sigma of corridor image

laplacian = laplacian_filter(im, 9, 1);
figure(3);
imshow(laplacian);

laplacian = laplacian_filter(im, 9, 3);
figure(4);
imshow(laplacian);

laplacian = laplacian_filter(im, 9, 5);
figure(5);
imshow(laplacian);



