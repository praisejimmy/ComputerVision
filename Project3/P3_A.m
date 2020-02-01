clc;
clear m;
clear n;
close all;
%RGB image of board
rgb_board = imread('go1.jpg');
%BW image of black go piece
black_piece = rgb2gray(imread('go_piece_black.jpg'));
%BW image of white go piece
white_piece = rgb2gray(imread('go_piece_white_1.jpg'));
%BW image of board
board = rgb2gray(imread('go1.jpg'));
%Apply a median filter to smooth out the pieces
board = median_filter(board,5);

%Perform template matching to the board using the white and black go pieces
black_corr = normxcorr2(black_piece,board);
white_corr = normxcorr2(white_piece,board);
%figure, surf(c), shading flat

%Find locations of pieces that are within the realm of the highest
%correllation 
[ypeak_b, xpeak_b] = find(black_corr>=0.737*max(black_corr(:)));
[ypeak_w, xpeak_w] = find(white_corr>=0.82*max(white_corr(:)));

%Find the number of correlated coordinates for each piece
[m_b,n_b] = size([ypeak_b, xpeak_b]);
[m_w,n_w] = size([ypeak_w, xpeak_w]);

%Adjust every coordinate by the size of the original image
for row = 1:m_b
    ypeak_b(row) = ypeak_b(row) - size(black_piece,1);
    xpeak_b(row) = xpeak_b(row) - size(black_piece,2);
end
hFig = figure;
hAx = axes;

for row = 1:m_w
    ypeak_w(row) = ypeak_w(row) - size(white_piece,1);
    xpeak_w(row) = xpeak_w(row) - size(white_piece,2);
end

%Overlay a rectangle on the board for every region of correlation
imshow(rgb_board,'Parent', hAx);
for row = 1:m_b
    if(row > 1)
        if(xpeak_b(row) > 9+xpeak_b(row-1) || ypeak_b(row) > 5+ ypeak_b(row-1) || xpeak_b(row) < xpeak_b(row-1)-9 || ypeak_b(row) <= ypeak_b(row-1)-1)
            imrect(hAx, [xpeak_b(row), ypeak_b(row), size(black_piece,2), size(black_piece,1)]);
        end
    end
end

for row = 1:m_w
    imrect(hAx, [xpeak_w(row), ypeak_w(row), size(white_piece,2), size(white_piece,1)]);
end
