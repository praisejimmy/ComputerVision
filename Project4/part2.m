clc

im_a = imread('bikes1.ppm');
im_gray = rgb2gray(im_a);
points = detectFASTFeatures(im_gray);
locs_a = uint32(points.selectStrongest(100).Location);
descriptors_a = my_extractFeatures_a(im_a, locs_a);

im_a2 = imread('bikes2.ppm');
im_gray = rgb2gray(im_a2);
points = detectFASTFeatures(im_gray);
locs_a2 = uint32(points.selectStrongest(100).Location);
descriptors_a2 = my_extractFeatures_a(im, locs_a2);

matches_a = uint32(find_best_match(descriptors_a, locs_a, descriptors_a2, locs_a2));
figure(4);
showMatchedFeatures(im_a, im_a2, locs_a, matches_a);

im_bike1 = imread('bikes1.ppm');
im_bike_1_gray = rgb2gray(im_bike1);
points_bike_1 = detectSURFFeatures(im_bike_1_gray);
locs1 = uint32(points_bike_1.selectStrongest(100).Location);
descriptors1 = my_extractFeatures_b(im_bike1, locs1);
im_bike2 = imread('bikes2.ppm');
im_bike_2_gray = rgb2gray(im_bike2);
points_bike_2 = detectSURFFeatures(im_bike_2_gray);
locs2 = uint32(points_bike_2.selectStrongest(100).Location);
descriptors2 = my_extractFeatures_b(im_bike1, locs2);


matches = uint32(find_best_match(descriptors1, locs1, descriptors2, locs2));
figure(1);
showMatchedFeatures(im_bike1, im_bike2, locs1, matches);

im_wall1 = imread('wall1.ppm');
im_wall_1_gray = rgb2gray(im_wall1);
points_wall_1 = detectSURFFeatures(im_wall_1_gray);
wall_locs = uint32(points_wall_1.selectStrongest(100).Location);
wall_descriptors = my_extractFeatures_b(im_wall1, wall_locs);
im_wall2 = imread('wall2.ppm');
im_wall_2_gray = rgb2gray(im_wall2);
points_wall_2 = detectSURFFeatures(im_wall_2_gray);
wall_locs2 = uint32(points_wall_2.selectStrongest(100).Location);
wall_descriptors2 = my_extractFeatures_b(im_wall1, wall_locs2);


matches2 = uint32(find_best_match(wall_descriptors, wall_locs, wall_descriptors2, wall_locs2));
figure(2);
showMatchedFeatures(im_wall1, im_wall2, wall_locs, matches2);

im_cars1 = imread('cars1.ppm');
im_cars_1_gray = rgb2gray(im_cars1);
points_cars_1 = detectSURFFeatures(im_cars_1_gray);
cars_locs = uint32(points_cars_1.selectStrongest(100).Location);
cars_descriptors = my_extractFeatures_b(im_cars1, cars_locs);
im_cars2 = imread('cars2.ppm');
im_cars_2_gray = rgb2gray(im_cars2);
points_cars_2 = detectSURFFeatures(im_cars_2_gray);
cars_locs2 = uint32(points_cars_2.selectStrongest(100).Location);
cars_descriptors2 = my_extractFeatures_b(im_cars1, cars_locs2);


matches3 = uint32(find_best_match(cars_descriptors, cars_locs, cars_descriptors2, cars_locs2));
figure(3);
showMatchedFeatures(im_cars1, im_cars2, cars_locs, matches3);