%testing the effects of parameters in Canny edge detector

% I = imread('corner_window.jpg');
% I = rgb2gray(I);
% 
% CannyTest(I);
% pause
% I = imread('corridor.jpg');
% I = rgb2gray(I);
% CannyTest(I);
% pause
% I = imread('New York City.jpg');
% I = rgb2gray(I);
% CannyTest(I);
% pause
I = imread('bike-lane.jpg');
I = rgb2gray(I);
CannyTest(I);
% pause
