function [text] = read_plate(im)
%READ_PLATE Summary of this function goes here
%   Detailed explanation goes here
char_lut = [0 1 2 3
im = rgb2gray(im);
im = medfilt2(im);
E=edge(im,'canny',[0.4*0.6 0.6],2.5);
conn = bwconncomp(E);
res = regionprops(conn, 'BoundingBox');
image_size = size(im);
hold on;
figure(1000);
imshow(im);
for z =1: length(res)
    thisBB = res(z).BoundingBox;
    disp(thisBB(4));
    disp(0.3*image_size(1));
    %Applying a filter on the bounding boxes. 
    %Check if the ratio between height and width is around 2
    %Check if the heigh is within a ration of the height of the image
    if(((thisBB(4)/thisBB(3)) <= 2.4 && (thisBB(4)/thisBB(3)) >= 1.6) && (thisBB(4) > 0.3*image_size(1))) %
        rectangle('position', [thisBB(1), thisBB(2), thisBB(3), thisBB(4)], 'Edgecolor', 'g');
    end
end
hold off;
end

