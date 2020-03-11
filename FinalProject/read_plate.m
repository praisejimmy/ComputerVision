function [text] = read_plate(im)
%READ_PLATE Summary of this function goes here
%   Detailed explanation goes here
char_lut = ['0' '1' '2' '3' '4' '5' '6' '7' '8' '9' 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z'];
text = "";
im_gray = rgb2gray(im);
im_gray = medfilt2(im_gray);
e=edge(im_gray,'canny',[0.4*0.6 0.6],2.5);
conn = bwconncomp(e);
res = regionprops(conn, 'BoundingBox');
image_size = size(im_gray);
bbs = zeros(100, 4);
count = 1;
for z = 1:length(res)
    thisBB = res(z).BoundingBox;
    disp(thisBB(4));
    disp(0.3*image_size(1));
    %Applying a filter on the bounding boxes. 
    %Check if the ratio between height and width is around 2
    %Check if the heigh is within a ration of the height of the image
    if(((thisBB(4)/thisBB(3)) <= 2.4 && (thisBB(4)/thisBB(3)) >= 1.6) && (thisBB(4) > 0.3*image_size(1))) %
        %rectangle('position', [thisBB(1), thisBB(2), thisBB(3), thisBB(4)], 'Edgecolor', 'g');
        bbs(count,:) = thisBB;
        count = count + 1;
    end
end
% Apply all binary templates to bounded region and find highest correlation
bin_templates = dir(fullfile('CharacterBinaryTemplates/', '*.png'));
for i = 1:count - 1
    highest_corr = intmin;
    highest_corr_ind = 1;
    roi = uint8(zeros(bbs(i, 3), bbs(i, 4)));
    roi_coord = [uint8(bbs(i, 1)) uint8(bbs(i, 2))];
    roi = im_gray(roi_coord(2):roi_coord(2) + bbs(i, 4), roi_coord(1):roi_coord(1) + bbs(i, 3));
    roi = roi > (max(roi) * .7);
    roi = imcomplement(roi);
    roi = int8(roi * 1);
    for i = 1:length(bin_templates)
        num = int2str(i);
        curr_template = imread(strcat('CharacterBinaryTemplates/', num, '.png'));
        curr_template = imcomplement(curr_template);
        curr_template = int8(curr_template * 1);
        curr_template = imresize(curr_template, size(roi));
        curr_template = bin2correlation_mtx(curr_template);
        correlation_mtx = roi.*curr_template;
        correlation_coefficient = sum(correlation_mtx, 'all');
        if correlation_coefficient > highest_corr
            highest_corr = correlation_coefficient;
            highest_corr_ind = i;
        end
    end
    text = strcat(text, char_lut(highest_corr_ind));
end
end

