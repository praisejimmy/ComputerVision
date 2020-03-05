close all

I = imread('s1.jpg');
imshow(I)

roi = images.roi.ellipse('StripeColor','m');

draw(roi)