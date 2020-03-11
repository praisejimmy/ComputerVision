function [bin] = bin2correlation_mtx(bin)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
im_size = size(bin)
for i = 1:im_size(1)
    for j = 1:im_size(2)
        if bin(i, j) == 0
            bin(i, j) = -1;
        end
    end 
end
end

