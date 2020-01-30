clc;
clear m;
clear n;
piece = rgb2gray(imread('go_piece.jpg'));
board = rgb2gray(imread('go1.jpg'));
figure(1);
%imshowpair(board,piece,'montage')

c = normxcorr2(piece,board);
figure, surf(c), shading flat

[ypeak, xpeak] = find(c>=0.5*max(c(:)));

[m,n] = size([ypeak, xpeak]);

for row = 1:m
    ypeak(row) = ypeak(row) - size(piece,1);
    xpeak(row) = xpeak(row) - size(piece,2);
end
hFig = figure;
hAx = axes;

imshow(board,'Parent', hAx);
for row = 1:m
    if(row > 1)
        if(xpeak(row) > 30+xpeak(row-1) || ypeak(row) > 20+ypeak(row-1) || xpeak(row) < xpeak(row-1)-30 || ypeak(row) < ypeak(row-1)-20)
            imrect(hAx, [xpeak(row), ypeak(row), size(piece,2), size(piece,1)]);
        end
    end
end
