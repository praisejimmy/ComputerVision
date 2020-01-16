function [resized] = lowerres(i)
%lowerres decreases the horizontal and vertical resolution
%by half
[rows, cols, layers] = size(i);
a = 1;
b = 1;
c = 1;
resized = zeros(rows/2, cols/2, layers);
resized = uint8(resized);

for x = 1:2:rows - 1
    for y = 1:2:cols - 1
        for z = 1:layers
            resized(a, b, c) = i(x, y, z);
            c = c + 1;
        end
        b = b + 1;
        c = 1;
    end
    a = a + 1;
    b = 1;
    c = 1;
end
end

