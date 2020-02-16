function [extracted_features] = my_extractFeatures_b(image, detected_pts)
%MY_EXTRACTFEATURES_B Summary of this function goes here
%   Detailed explanation goes here

image = rgb2gray(image);

sy = (1/8).*fspecial('sobel');
sx = sy';

g = fspecial('gaussian', 16, 0.5);

pts_size = size(detected_pts);
extracted_features = zeros(pts_size(1), 128);

image = padarray(image, [12 12], 0, 'both');

feature_vectors = zeros(pts_size);

for i = 1:pts_size(1)
    x = detected_pts(i, 1) + 12;
    y = detected_pts(i, 2) + 12;
    neighbors = image(y - 8:y + 7, x - 8:x + 7);
    imfilter(neighbors, g);
    hist_cnt = 0;
    for jy = 1: +4: 15
        for jx = 1: +4: 15
           cell = double(neighbors(jy:jy+3, jx: jx+3));
           sobel_x = imfilter(cell, sx);
           sobel_y = imfilter(cell, sy);
           hist = build_hist(sobel_x, sobel_y);
           extracted_features(i, 1 + (hist_cnt * 8):(hist_cnt * 8) + 8) = hist;
           hist_cnt = hist_cnt + 1;
        end
    end
  
end 
end

