close all;
original = imread('s20.jpg');

figure(1);
imshow(original);

roi = drawpolygon('StripeColor', 'm');

BW = createMask(roi);

figure(2);
imshow(BW);
imwrite(BW, "s20_mask.jpg");