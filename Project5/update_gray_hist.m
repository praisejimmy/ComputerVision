function [hist] = update_gray_hist(im, hist)
% updates a grayscale histogram given an image 

im_size = size(im);
for i = 1:im_size(1)
    for j = 1:im_size(2)
        hist(im(i, j) + 1) = hist(im(i, j) + 1) + 1;
    end 
end
hist(1) = 0;
end

