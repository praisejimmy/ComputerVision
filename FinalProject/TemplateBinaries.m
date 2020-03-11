close all

templates = dir(fullfile('./CharacterTemplates/', '*.PNG'));
g = fspecial('gaussian', 3, .7);
for i = 1:length(templates)
    im = imread(strcat('./CharacterTemplates/', templates(i).name));
    im = rgb2gray(im);
    maxval = max(im, [], 'all');
    disp(maxval)
    bin = im > (maxval * .55);
    imwrite(bin, strcat('CharacterBinaryTemplates/', int2str(i), '.png'));
end