function [text] = read_plate(im)
% READ_PLATE Given a photo of a license plate, returns a text with all
% characters on the plate

% Look up table to be indexed by best matched character template
char_lut = ['0' '1' '2' '3' '4' '5' '6' '7' '8' '9' 'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z'];
% Final output string to append read characters onto
text = "";

% Change input image to grayscale and filter out impulse noise
im_gray = rgb2gray(im);
im_gray = medfilt2(im_gray);

% Apply a canny edge detector and use connected component analysis
% to isolate plate character regions in bounding boxes
e=edge(im_gray,'canny',[0.4*0.6 0.6],2.5);
conn = bwconncomp(e);
res = regionprops(conn, 'BoundingBox');
image_size = size(im_gray);
bbs = zeros(100, 4);
count = 1;
% Analyse each bounding box to determine if a character or not
for z = 1:length(res)
    thisBB = res(z).BoundingBox;
    %Applying a filter on the bounding boxes. 
    %Check if the ratio between height and width is around 2
    %Check if the heigh is within a ratio of the height of the image
    if(((thisBB(4)/thisBB(3)) <= 2.4 && (thisBB(4)/thisBB(3)) >= 1.6) && (thisBB(4) > 0.3*image_size(1)) && (thisBB(3) > 3))
        bbs(count,:) = thisBB;
        count = count + 1;
    end
end
% Apply all binary templates to bounded region and find highest correlation
bin_templates = dir(fullfile('CharacterBinaryTemplates/', '*.png'));
for i = 1:count - 1
    highest_corr = intmin;
    highest_corr_ind = 1;
    % Grab region of interest from original image using current bouding box
    roi_coord = [uint32(floor(bbs(i, 1))) uint32(floor(bbs(i, 2)))];
    roi = im_gray(roi_coord(2):roi_coord(2) + bbs(i, 4), roi_coord(1):roi_coord(1) + bbs(i, 3));
    % Create binary image from ROI, extract HOG features to be used in
    % comparison
    roi = roi > (max(roi) * .7);
    roi = imcomplement(roi);
    roi = uint8(roi * 255);
    roi_descriptors = extractHOGFeatures(roi);
    roi = int8(roi / 255);
    % Find correlation between ROI and every character template to find
    % highest correlation
    for j = 1:length(bin_templates)
        num = int2str(j);
        curr_template = imread(strcat('CharacterBinaryTemplates/', num, '.png'));
        curr_template = imcomplement(curr_template);
        curr_template = uint8(curr_template * 255);
        % Resize template to be exact match to ROI
        curr_template = imresize(curr_template, size(roi));
        % Extract HOG features from template
        template_descriptors = extractHOGFeatures(curr_template);
        % Create correlation matrix to be used in template matching from
        % binary template (used to provide heavy anti-correlation for
        % unmatched pixels)
        curr_template = int8(curr_template / 255);
        curr_template = bin2correlation_mtx(curr_template);
        correlation_mtx = roi.*curr_template;
        % Calculate correlation coefficient from template matching and
        % euclidean distance of feature vectors
        correlation_coefficient = sum(correlation_mtx, 'all');
        correlation_coefficient = correlation_coefficient * sqrt(sum((roi_descriptors - template_descriptors) .^ 2));
        if correlation_coefficient > highest_corr
            highest_corr = correlation_coefficient;
            highest_corr_ind = j;
        end
    end
    % Append highest correlated character to output string
    text = strcat(text, char_lut(highest_corr_ind));
end
end

