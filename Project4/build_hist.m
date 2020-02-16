function [hist] = build_hist(sobel_x, sobel_y)
%BUILD_HIST Summary of this function goes here
%   Detailed explanation goes here
hist = zeros(1, 8);
sobel_angles = zeros(size(sobel_x));
sobel_x = double(sobel_x);
sobel_y = double(sobel_y);
sobel_mag = (sobel_x.^2 + sobel_y.^2).^0.5;
for i = 1: 4
    for j = 1: 4
        a = atan2(double(sobel_y(i, j)), double(sobel_x(i, j)));
        if a < 0
            a = a + (2 * pi);
        end
        sobel_angles(i, j) = a;
    end 
end
for i = 1: 4
    for j = 1: 4
        hist_ind = uint8(floor(sobel_angles(i, j) / (pi/4))) + 1;
        hist(hist_ind) = hist(hist_ind) + sobel_mag(i, j);
    end 
end
end

