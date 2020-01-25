function [filtered] = gaussian_filter(im, sigma, mask_size)
%GAUSSIAN_FILTER Summary of this function goes here
%   Detailed explanation goes here

x=[-floor(mask_size / 2):1:floor(mask_size / 2)];
px=1/(sqrt(2*pi)*sigma)*exp(-x.^2/(2*sigma^2));
py=px';
g = py * px;
normalizing_factor=sum(sum(g));
g = g/normalizing_factor;

im_size = size(im);
filtered = uint8(zeros(im_size));
pad_size = floor(mask_size / 2);
im = padarray(im, [pad_size pad_size], 0, 'both');

for i = pad_size + 1:im_size(1)
    for j = pad_size + 1:im_size(2)
        neighbors = im(i-pad_size:i+pad_size, j-pad_size:j+pad_size);
        neighbors = double(neighbors);
        cmat = neighbors.*g;
        cval = sum(sum(cmat));
        filtered(i - pad_size, j - pad_size) = uint8(cval);
    end
end

end

