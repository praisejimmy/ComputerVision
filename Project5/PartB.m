close all

%image = imread("t6.jpg");

%[L, centers] = imsegkmeans(image, 7);
%B = labeloverlay(image,L);
%imshow(B)
%title('Labeled Image')

img = imread("t6.jpg");
%img = imresize(img, 0.1);
maskOut=emmpm(img,6,3);
im_size = size(img);
mask_size = size(maskOut);

straw_boxes = double(zeros(10000,4));
count = 1;
num_straw = 0;
for i = 1: 6
    temp_image = uint8(zeros(mask_size));
    binary_image = uint8(zeros(mask_size(1), mask_size(2)));
    for j = 1: mask_size(1)
        for k = 1: mask_size(2)
            if(maskOut(j,k) == i)
               temp_image(j,k,1) = img(j+1,k+1,1);
               temp_image(j,k,2) = img(j+1,k+1,2);
               temp_image(j,k,3) = img(j+1,k+1,3);
               binary_image(j,k) = 1;
            else
               temp_image(j,k,1) = 0;
               temp_image(j,k,2) = 0;
               temp_image(j,k,3) = 0;
               binary_image(j,k) = 0;
            end
        end
    end
    %figure(i+2);
    %imshow(temp_image);
    %figure(i+100);
    %imshow(binary_image, []);
    %figure(i+200);
    %imshow(conn, []);
    conn = bwconncomp(binary_image);
    res = regionprops(conn, {'BoundingBox','Centroid'});
    centroids = cat(1,res.Centroid);
    bb = cat(1, res.BoundingBox);
    %plot(centroids(:,1),centroids(:,2),'b*')
    for l = 1:size(bb,1)
        temp = bb(l,:);
        temp_rect = uint8(zeros(temp(4),temp(3),3));
        for x = uint8(temp(1)+0.5): uint8(temp(1)+0.5)+uint8(temp(3))
            for y = uint8(temp(2)+0.5):uint8(temp(2)+0.5)+uint8(temp(4))
                if x <= im_size(1) && y< im_size(2)
                    temp_x = x-uint8(temp(1)+0.5)+1;
                    temp_y = y - uint8(temp(2)+0.5)+1;
                    temp_rect(temp_x, temp_y,1) = img(x,y,1);
                    temp_rect(temp_x, temp_y,2) = img(x,y,2);
                    temp_rect(temp_x, temp_y,3) = img(x,y,3);
                end
            end
        end
        red_hist = histogram(temp_rect(:,:,1),5);
        r_bin_edge = int8(red_hist.BinEdges(I_RED));
        r_max_avg = int8((abs(red_hist.BinEdges(I_RED+1)) + abs(red_hist.BinEdges(I_RED)))/2);
        [max_red, I_RED] = max(red_hist.Values);
        green_hist = histogram(temp_rect(:,:,2),5);
        g_bin_edge = int8(green_hist.BinEdges(I_GREEN));
        g_max_avg = int8((abs(green_hist.BinEdges(I_GREEN+1)) + abs(green_hist.BinEdges(I_GREEN)))/2);
        [max_green, I_GREEN] = max(green_hist.Values);
        blue_hist = histogram(temp_rect(:,:,3),5);
        b_bin_edge = int8(blue_hist.BinEdges(I_BLUE));
        b_max_avg = int8((abs(blue_hist.BinEdges(I_BLUE+1)) + abs(blue_hist.BinEdges(I_BLUE)))/2);
        [max_blue, I_BLUE] = max(blue_hist.Values);
        
        if(((r_bin_edge ~= 0 || r_max_avg ~= 0) && temp(3) > 3.0 && temp(4) > 3.0) && g_max_avg < 30)
            num_straw = num_straw + 1;
            straw_boxes(count,:) = temp;
            count = count + 1;
        end
    end
end


hold on;
figure(1000);
imshow(img);
for z =1: 10000
    rectangle('position', straw_boxes(z,:), 'Edgecolor', 'g');
end
disp(num_straw);
hold off;
        

