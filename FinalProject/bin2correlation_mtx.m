function [bin] = bin2correlation_mtx(bin)
%BIN2CORRELATION_MTX Creates a correlation matrix to be used in template
%matching given a binary image. All 0 pixels are changed to -10 to provide
%heavy anti-correlation values for unmatched pixels.

im_size = size(bin);
for i = 1:im_size(1)
    for j = 1:im_size(2)
        if bin(i, j) == 0
            bin(i, j) = -10;
        end
    end 
end
end

