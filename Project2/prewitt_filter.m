function [filtered] = prewitt_filter(img)
%GAUSSIAN_FILTER Summary of this function goes here
%   Detailed explanation goes here

im = rgb2gray(img);

%The sobel filter
px= [-1,-1,-1;0,0,0;1,1,1];
py=px';

%Create the filters for px and py and the output arrays
im_size = size(im);
gx = double(zeros(im_size));
gy = double(zeros(im_size));
filtered = double(zeros(im_size));
pad_size = floor(3 / 2);
im = padarray(im, [pad_size pad_size], 0, 'both');

%Apply the px filter to get Gx
for i = pad_size + 1:im_size(1)
    for j = pad_size + 1:im_size(2)
        neighbors = im(i-pad_size:i+pad_size, j-pad_size:j+pad_size);
        neighbors = double(neighbors);
        cmat = neighbors.*px;
        cval = sum(sum(cmat));
        gx(i - pad_size, j - pad_size) = double(cval);
    end
end

%Apply the py filter to get Gy
for i = pad_size + 1:im_size(1)
    for j = pad_size + 1:im_size(2)
        neighbors = im(i-pad_size:i+pad_size, j-pad_size:j+pad_size);
        neighbors = double(neighbors);
        cmat = neighbors.*py;
        cval = sum(sum(cmat));
        gy(i - pad_size, j - pad_size) = double(cval);
    end
end

%Compute the magnitude of the gradient
filtered = (gx.^2 + gy.^2).^0.5;
temp = filtered;
filtered = double(rescale(temp));

%Apply the threshold and output the image
filtered = filtered>0.17*max(filtered(:));

end

