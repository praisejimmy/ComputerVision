function [filtered] = laplacian_filter(im)
%GAUSSIAN_FILTER Summary of this function goes here
%   Detailed explanation goes here


lp= [0,-1,0;-1,4,-1;0,-1,0];

im_size = size(im);
filtered = uint8(zeros(im_size));
pad_size = floor(3 / 2);
im = padarray(im, [pad_size pad_size], 0, 'both');

for i = pad_size + 1:im_size(1)
    for j = pad_size + 1:im_size(2)
        neighbors = im(i-pad_size:i+pad_size, j-pad_size:j+pad_size);
        neighbors = double(neighbors);
        cmat = neighbors.*lp;
        cval = sum(sum(cmat));
        filtered(i - pad_size, j - pad_size) = uint8(cval);
    end
end

end

