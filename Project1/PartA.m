clc
i = imread('BigSur.jpg');
s = dir('BigSur.jpg');
imshow(i);
gri = rgb2gray(i);
imshow(gri);
maxint = max(gri(:));
minint = min(gri(:));
[maxrow, maxcol] = find(gri == maxint);
[minrow, mincol] = find(gri == minint);
fprintf('Maximum intensity: %d at location %d, %d\n', maxint, maxrow(1), maxcol(1));
fprintf('Minimum intensity: %d at location %d, %d\n', minint, minrow(1), mincol(1));
fprintf('Image size: %d\n', s.bytes);

resized = lowerres(i);
imshow(resized);
resized = lowerres(resized);
imshow(resized);
resized = lowerres(resized);
imshow(resized);
resized = lowerres(resized);
imshow(resized);
resized = lowerres(resized);
imshow(resized);
resized = lowerres(resized);
imshow(resized);
