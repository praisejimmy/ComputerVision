function [filtered] = median_filter(im, mask_size)
%MEDIAN_FILTER Summary of this function goes here
%   Detailed explanation goes here
if mod(mask_size, 2) == 0 || mask_size < 3
    return
end

im_size = size(im);
filtered = uint8(zeros(im_size));
pad_size = floor(mask_size / 2);
im = padarray(im, [pad_size pad_size], 0, 'both');

for i = pad_size + 1:im_size(1)
    for j = pad_size + 1:im_size(2)
        neighbors = im(i-pad_size:i+pad_size, j-pad_size:j+pad_size);
        neighbors = neighbors(:)';
        filtered(i - pad_size, j - pad_size) = uint8(floor(median(neighbors)));
    end
end

