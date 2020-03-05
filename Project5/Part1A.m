close all

mask = imread('s1_mask.jpg');
original = imread('s1.jpg');

size_mask = size(mask);
size_original = size(original);

for i = 1: size_mask(1)
    for j = 1: size_mask(2)
        if(mask(i,j) == 0)
            original(i,j,1) = 0;
            original(i,j,2) = 0;
            original(i,j,3) = 0;
        end
    end
end

figure(1);
imshow(original);
%Apply the mask to the image and find color distribution


