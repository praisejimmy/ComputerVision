close all

% initialize RGB background and foreground histograms
fore_r_hist = uint32(zeros(1, 255));
fore_g_hist = uint32(zeros(1, 255));
fore_b_hist = uint32(zeros(1, 255));

back_r_hist = uint32(zeros(1, 255));
back_g_hist = uint32(zeros(1, 255));
back_b_hist = uint32(zeros(1, 255));

% all files for images and their masks
myFiles = dir(fullfile('S','*.jpg'));
myMasks = dir(fullfile('s_mask','*.jpg'));

size_mask = size(imread(strcat('S/', myFiles(1).name)));
size_original = size(imread(strcat('S/', myFiles(1).name)));

% create filtered images to only show strawberries
for k = 1:length(myFiles)
    num = int2str(k);
    original = imread(strcat('S/s', num, '.JPG'));
    mask = imread(strcat('s_mask/s', num, '_mask.JPG')) > 0;
    for i = 1: size_mask(1)
        for j = 1: size_mask(2)
            if mask(i,j) == 0
                original(i,j,1) = 0;
                original(i,j,2) = 0;
                original(i,j,3) = 0;
            end
        end
    end
    imwrite(original, strcat('foreground/fore_', myFiles(k).name)); 
end

% create filtered images to only show backgrounds
for k = 1:length(myFiles)
    num = int2str(k);
    original = imread(strcat('S/s', num, '.JPG'));
    mask = imread(strcat('s_mask/s', num, '_mask.JPG')) > 0;
    for i = 1: size_mask(1)
        for j = 1: size_mask(2)
            if mask(i,j) == 1
                original(i,j,1) = 0;
                original(i,j,2) = 0;
                original(i,j,3) = 0;
            end
        end
    end
    imwrite(original, strcat('background/back_', myFiles(k).name)); 
end

foreground_images = dir(fullfile('foreground', '*.jpg'));
background_images = dir(fullfile('background', '*.jpg'));

% initialize the gray scale and HSV histograms
im = imread(strcat('foreground/', foreground_images(1).name));
grayImage = rgb2gray(im);
hsvImage = rgb2hsv(im);
fore_gray_hist = update_gray_hist(grayImage, uint32(zeros(1, 255)));
h = hsvImage(:, :, 1);
fore_h_hist = hist(h(:), 40);
s = hsvImage(:, :, 2);
fore_s_hist = hist(s(:), 40);
v = hsvImage(:, :, 3);
fore_v_hist = hist(v(:), 40);

% fill in all histograms for strawberry images
for k = 1:length(foreground_images)
    im = imread(strcat('foreground/', foreground_images(k).name));
    [fore_r_hist, fore_g_hist, fore_b_hist] = update_rgb_hist(im, fore_r_hist, fore_g_hist, fore_b_hist);
    if k ~= 1
        grayImage = rgb2gray(im);
        hsvImage = rgb2hsv(im);
        fore_gray_hist = update_gray_hist(grayImage, fore_gray_hist);
        h = hsvImage(:, :, 1);
        fore_h_hist = fore_h_hist + hist(h(:), 40);
        s = hsvImage(:, :, 2);
        fore_s_hist = fore_s_hist + hist(s(:), 40);
        v = hsvImage(:, :, 3);
        fore_v_hist = fore_v_hist + hist(v(:), 40);
    end
end

fore_h_hist(1) = 0;
fore_s_hist(1) = 0;
fore_v_hist(1) = 0;

im = imread(strcat('background/', background_images(1).name));
grayImage = rgb2gray(im);
hsvImage = rgb2hsv(im);
back_gray_hist = update_gray_hist(grayImage, uint32(zeros(1, 255)));
h = hsvImage(:, :, 1);
back_h_hist = hist(h(:), 40);
s = hsvImage(:, :, 2);
back_s_hist = hist(s(:), 40);
v = hsvImage(:, :, 3);
back_v_hist = hist(v(:), 40);

% fill in all histograms for background images
for k = 1:length(background_images)
    im = imread(strcat('background/', background_images(k).name));
    [back_r_hist, back_g_hist, back_b_hist] = update_rgb_hist(im, back_r_hist, back_g_hist, back_b_hist);
    if k ~= 1
        grayImage = rgb2gray(im);
        hsvImage = rgb2hsv(im);
        back_gray_hist = update_gray_hist(grayImage, back_gray_hist);
        h = hsvImage(:, :, 1);
        back_h_hist = back_h_hist + hist(h(:), 40);
        s = hsvImage(:, :, 2);
        back_s_hist = back_s_hist + hist(s(:), 40);
        v = hsvImage(:, :, 3);
        back_v_hist = back_v_hist + hist(v(:), 40);
    end
end

back_h_hist(1) = 0;
back_s_hist(1) = 0;
back_v_hist(1) = 0;

scale = linspace(0, 1.0, 40);

% plot all histograms
figure('Name', 'Foreground red histogram')
bar(fore_r_hist);
figure('Name', 'Foreground green histogram')
bar(fore_g_hist);
figure('Name', 'Foreground blue histogram')
bar(fore_b_hist);
figure('Name', 'Foreground gray histogram')
bar(fore_gray_hist);
figure('Name', 'Foreground hue histogram')
bar(scale, fore_h_hist);
figure('Name', 'Foreground saturation histogram')
bar(scale, fore_s_hist);
figure('Name', 'Foreground value histogram')
bar(scale, fore_v_hist);

figure('Name', 'Background red histogram')
bar(back_r_hist);
figure('Name', 'Background green histogram')
bar(back_g_hist);
figure('Name', 'Background blue histogram')
bar(back_b_hist);
figure('Name', 'Background gray histogram')
bar(back_gray_hist);
figure('Name', 'Background hue histogram')
bar(scale, back_h_hist);
figure('Name', 'Background saturation histogram')
bar(scale, back_s_hist);
figure('Name', 'Background value histogram')
bar(scale, back_v_hist);




