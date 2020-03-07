function [hist] = update_gray_hist(im, hist)
%UPDATE_GRAY_HIST Summary of this function goes here
%   Detailed explanation goes here
im_size = size(im);
for i = 1:im_size(1)
    for j = 1:im_size(2)
        hist(im(i, j) + 1) = hist(im(i, j) + 1) + 1;
    end 
end
hist(1) = 0;
end

