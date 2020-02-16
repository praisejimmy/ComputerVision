function [corners] = corner_detect(im)
%CORNER_DETECT Summary of this function goes here
%   Detailed explanation goes here
im = rgb2gray(im);

k = 0.04;
sx = (1/8).*fspecial('sobel');
sy = sx';
g = fspecial('gaussian');
im_size = size(im);

ix = imfilter(im, sx);
iy = imfilter(im, sy);

ix2 = ix.*ix;
iy2 = iy.*iy;
ixy = ix.*iy;

ix2 = imfilter(ix2, g);
iy2 = imfilter(iy2, g);
ixy = imfilter(ixy, g);

r = zeros(im_size);
h = zeros(2);
for i = 1:im_size(1)
    for j = 1:im_size(2)
        h(1, 1) = ix2(i, j);
        h(1, 2) = ixy(i, j);
        h(2, 1) = ixy(i, j);
        h(2, 2) = iy2(i, j);
        r(i, j) = det(h) - k * (trace(h)).^2;
    end
end

max_r = max(r, [], 'all');
thresh = max_r * 0.3;
for i = 1:im_size(1)
    for j = 1:im_size(2)
        if r(i, j) < thresh
            r(i, j) = 0;
        end 
    end 
end 

r = padarray(r, [1 1], 0, 'both');

for i = 2:im_size(1) - 1
    for j = 2:im_size(2) - 1
        neighbors = r(i-1:i+1, j-1:j+1);
        neighbors(2, 2) = 0;
        max_n = max(neighbors, [], 'all');
        if r(i, j) < max_n
            r(i, j) = 0;
        end
    end
end 

r = r > 0;
r = r(2:end - 1, 2:end - 1);
corners = r;
end

