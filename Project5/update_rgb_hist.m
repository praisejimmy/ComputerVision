function [r_hist, g_hist, b_hist] = update_rgb_hist(im, r_hist, g_hist, b_hist)
% Updates given histograms with data from all pixels in im

im_size = size(im);
for i = 1: im_size(1)
    for j = 1: im_size(2)
        r_hist(im(i, j, 1) + 1) = r_hist(im(i, j, 1) + 1) + 1;
        g_hist(im(i, j, 2) + 1) = g_hist(im(i, j, 1) + 1) + 1;
        b_hist(im(i, j, 3) + 1) = b_hist(im(i, j, 1) + 1) + 1;
    end
end
r_hist(1) = 0;
g_hist(1) = 0;
b_hist(1) = 0;
end

