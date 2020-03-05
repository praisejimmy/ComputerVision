clc

im = checkerboard;
figure(1);
imshow(im);
c = corner_detect(im);
comp = imfuse(c, im);
figure(2);
imshow(comp);