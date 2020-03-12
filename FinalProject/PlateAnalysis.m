close all
images = dir(fullfile('./PlateSamples', '*.png'));
% Read in every number plate sample photo
for i = 1:length(images)
    im = imread(strcat('./PlateSamples/', images(i).name));
    % Read the text on the plate and display
    text = read_plate(im);
    disp(text);
    imshow(im);
    pause;
end 