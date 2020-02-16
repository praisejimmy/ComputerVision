function [extracted_features] = my_extractFeatures_a(image, detected_pts)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

image = rgb2gray(image);

pts_size = size(detected_pts);
extracted_features = zeros(pts_size(1), 25);

image = padarray(image, [2 2], 0, 'both');

for i = 1:pts_size(1)
    x = detected_pts(i, 1) + 2;
    y = detected_pts(i, 2) + 2;
    neighbors = image(y - 2:y + 2, x - 2:x + 2);
    extracted_features(i, :) = reshape(neighbors, 1, 25);
end 
end

