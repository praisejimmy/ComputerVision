close all
im = imread('./PlateSamples/ca1635.png');
images = dir(fullfile('./PlateSamples', '*.png'));
g = fspecial('gaussian', 3, .7);
for i = 1:length(images)
    im = imread(strcat('./PlateSamples/', images(i).name));
    read_plate(im);
end 