function [best_match] = find_best_match(feat_desc_im_1, locs_1, feat_desc_im_2, locs_2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

best_match = zeros(100, 2);
size_desc1 = size(feat_desc_im_1);
size_desc2 = size(feat_desc_im_2);

for i = 1: size_desc1(1)
    val1 = feat_desc_im_1(i, :);
    smallest = intmax('uint32');
    best_point = zeros(1, 2);
    for j = 1: size_desc2(1)
        val2 = feat_desc_im_2(j, :);
        dist = sqrt(sum((val1(1, :) - val2(1, :)) .^ 2));
        if dist <= smallest
            smallest = dist;
            best_point = locs_2(j, :);
        end
    end
%     if smallest > 1000
%         best_match(i, :) = [0 0];
%     else
        best_match(i, :) = best_point(:);
%     end
end

end