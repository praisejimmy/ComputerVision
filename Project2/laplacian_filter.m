function [filtered] = laplacian_filter(img, mask_size, sig)
%GAUSSIAN_FILTER Summary of this function goes here
%   Detailed explanation goes here

im = rgb2gray(img);

%Create the Laplacian of gaussian filter
lp = fspecial('log', mask_size, sig);

%Create the output array and pad the original image to add the filter
im_size = size(im);
filtered_log = double(zeros(im_size));
pad_size = floor(mask_size / 2);
im = padarray(im, [pad_size pad_size], 0, 'both');

%Apply the filter to each pixel
for i = pad_size + 1:im_size(1)
    for j = pad_size + 1:im_size(2)
        neighbors = im(i-pad_size:i+pad_size, j-pad_size:j+pad_size);
        neighbors = double(neighbors);
        cmat = neighbors.*lp;
        cval = sum(sum(cmat));
        filtered_log(i - pad_size, j - pad_size) = double(cval);
    end
end

%Create the output array
im_size = size(filtered_log);
filtered = uint8(zeros(im_size));
pad_size = floor(3 / 2);
filtered_temp = padarray(filtered_log, [pad_size pad_size], 0, 'both');

%Apply the zero crossing to the filtered image
for i = pad_size + 1:im_size(1)
    for j = pad_size + 1:im_size(2)
        neighbors = filtered_temp(i-pad_size:i+pad_size, j-pad_size:j+pad_size);
        neighbors = double(neighbors);
        if (neighbors(1,2)*neighbors(3,2)) < 0 || (neighbors(2,1)* neighbors(2,3)) < 0 || (neighbors(1,1) * neighbors(3,3)) < 0 || (neighbors(1,3) * neighbors(3,1) < 0)
            filtered(i - pad_size, j - pad_size) = 255;
        else
            filtered(i - pad_size, j - pad_size) = 0;
        end
    end
end

end

