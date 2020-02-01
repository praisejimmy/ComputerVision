function [result] = rps(im)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
r_corrs = 1:3;
p_corrs = 1:3;
s_corrs = 1:3;
results = 1:3;

im = rgb2gray(im);
im = imrotate(im, 270);

%% find maximum rock correlation
r_temp = imread('rock_template.jpg');
r_temp = rgb2gray(r_temp);
%r_temp = median_filter(r_temp, 3);

r_corr = normxcorr2(r_temp, im);

[ypeak_r, xpeak_r] = find(r_corr==max(r_corr(:)));
yoffSet_r = ypeak_r-size(r_temp,1);
xoffSet_r = xpeak_r-size(r_temp,2);
hAx = axes;
figure('Name', 'No resize image');
imshow(r_temp);
figure('Name', 'Rock no resize');
imshow(im,'Parent', hAx);
imrect(hAx, [xoffSet_r, yoffSet_r, size(r_temp,2), size(r_temp,1)]);

r_corrs(1) = max(r_corr(:));
r_temp = imresize(r_temp, 0.3);
figure('Name', 'Resized image');
imshow(r_temp);
r_corr = normxcorr2(r_temp, im);

[ypeak_r, xpeak_r] = find(r_corr==max(r_corr(:)));
yoffSet_r = ypeak_r-size(r_temp,1);
xoffSet_r = xpeak_r-size(r_temp,2);
hAx = axes;
figure('Name', 'Rock resize half');
imshow(im,'Parent', hAx);
imrect(hAx, [xoffSet_r, yoffSet_r, size(r_temp,2), size(r_temp,1)]);

r_corrs(2) = max(r_corr(:));
r_temp = imresize(r_temp, 0.3);
figure('Name', 'Resized image twice');
imshow(r_temp);
r_corr = normxcorr2(r_temp, im);
r_corrs(3) = max(r_corr(:));
results(1) = max(r_corrs);

[ypeak_r, xpeak_r] = find(r_corr==max(r_corr(:)));
yoffSet_r = ypeak_r-size(r_temp,1);
xoffSet_r = xpeak_r-size(r_temp,2);
hAx = axes;
figure('Name', 'Rock resize quarter');
imshow(im,'Parent', hAx);
imrect(hAx, [xoffSet_r, yoffSet_r, size(r_temp,2), size(r_temp,1)]);
disp(r_corrs)

%%

%% find maximum paper correlation
p_temp = imread('paper_template.jpg');
p_temp = rgb2gray(p_temp);
%p_temp = median_filter(p_temp, 3);

p_corr = normxcorr2(p_temp, im);

[ypeak_p, xpeak_p] = find(p_corr==max(p_corr(:)));
yoffSet_p = ypeak_p-size(p_temp,1);
xoffSet_p = xpeak_p-size(p_temp,2);
hAx = axes;
figure('Name', 'Paper original');
imshow(im,'Parent', hAx);
imrect(hAx, [xoffSet_p, yoffSet_p, size(p_temp,2), size(p_temp,1)]);

p_corrs(1) = max(p_corr(:));
p_temp = imresize(p_temp, 0.3);
p_corr = normxcorr2(p_temp, im);

[ypeak_p, xpeak_p] = find(p_corr==max(p_corr(:)));
yoffSet_p = ypeak_p-size(p_temp,1);
xoffSet_p = xpeak_p-size(p_temp,2);
hAx = axes;
figure('Name', 'Paper resize half');
imshow(im,'Parent', hAx);
imrect(hAx, [xoffSet_p, yoffSet_p, size(p_temp,2), size(p_temp,1)]);

p_corrs(2) = max(p_corr(:));
p_temp = imresize(p_temp, 0.3);
p_corr = normxcorr2(p_temp, im);
p_corrs(3) = max(p_corr(:));
results(2) = max(p_corrs);

[ypeak_p, xpeak_p] = find(p_corr==max(p_corr(:)));
yoffSet_p = ypeak_p-size(p_temp,1);
xoffSet_p = xpeak_p-size(p_temp,2);
hAx = axes;
figure('Name', 'Paper resize quarter');
imshow(im,'Parent', hAx);
imrect(hAx, [xoffSet_p, yoffSet_p, size(p_temp,2), size(p_temp,1)]);

disp(p_corrs)


%%

%% find maximum scissors correlation

s_temp = imread('scissors_template.jpg');
s_temp = rgb2gray(s_temp);
%s_temp = median_filter(s_temp, 3);

s_corr = normxcorr2(s_temp, im);

[ypeak_s, xpeak_s] = find(s_corr==max(s_corr(:)));
yoffSet_s = ypeak_s-size(s_temp,1);
xoffSet_s = xpeak_s-size(s_temp,2);
hAx = axes;
figure('Name', 'Scissors original');
imshow(im,'Parent', hAx);
imrect(hAx, [xoffSet_s, yoffSet_s, size(s_temp,2), size(s_temp,1)]);


s_corrs(1) = max(s_corr(:));
s_temp = imresize(s_temp, 0.3);
s_corr = normxcorr2(s_temp, im);

[ypeak_s, xpeak_s] = find(s_corr==max(s_corr(:)));
yoffSet_s = ypeak_s-size(s_temp,1);
xoffSet_s = xpeak_s-size(s_temp,2);
hAx = axes;
figure('Name', 'Scissors resize half');
imshow(im,'Parent', hAx);
imrect(hAx, [xoffSet_s, yoffSet_s, size(s_temp,2), size(s_temp,1)]);

s_corrs(2) = max(s_corr(:));
s_temp = imresize(s_temp, 0.3);
s_corr = normxcorr2(s_temp, im);
s_corrs(3) = max(s_corr(:));
results(3) = max(s_corrs);

[ypeak_s, xpeak_s] = find(s_corr==max(s_corr(:)));
yoffSet_s = ypeak_s-size(s_temp,1);
xoffSet_s = xpeak_s-size(s_temp,2);
hAx = axes;
figure('Name', 'Scissors resize quarter');
imshow(im,'Parent', hAx);
imrect(hAx, [xoffSet_s, yoffSet_s, size(s_temp,2), size(s_temp,1)]);

disp(s_corrs);

%%
disp(results);
[M, I] = max(results);
if I == 1
    result = 'rock';
elseif I == 2
    result = 'paper';
elseif I == 3
    result = 'scissors';
end
end

