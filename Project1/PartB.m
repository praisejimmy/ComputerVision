clc
i = imread('bacteria.bmp');
t = 100;
i = i < t;
imshow(i);

[c, n] = bwlabel(i, 8);
cc = bwconncomp(i);
stats = regionprops(cc, 'Area');
disp(n);
disp(stats);