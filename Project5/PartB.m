close all

%image = imread("t6.jpg");

%[L, centers] = imsegkmeans(image, 7);
%B = labeloverlay(image,L);
%imshow(B)
%title('Labeled Image')

maskOut=emmpm(img,15,10);
mask_size = size(maskOut);
figure(100);
imshow(maskOut,[]);

for i = 1: 15
    temp_image = uint8(zeros(mask_size));
    for j = 1: mask_size(1)
        for k = 1: mask_size(2)
            if(maskOut(j,k) == i)
               temp_image(j,k,1) = img(j+1,k+1,1);
               temp_image(j,k,2) = img(j+1,k+1,2);
               temp_image(j,k,3) = img(j+1,k+1,3);
            else
               temp_image(j,k,1) = 0;
               temp_image(j,k,2) = 0;
               temp_image(j,k,3) = 0;
            end
        end
    end
    figure(i+2);
    imshow(temp_image);
end
        

figure(1);  
imshow(maskOut);
%imwrite(maskOut, "t5_em_k25.jpg");

[n, edges] = histcounts(maskOut,3);

size_mask = size(maskOut);
hist_mask = size(edges);
lower_edge = 0.0;
upper_edge = edges(1,1);


for k = 1: hist_mask(2)
    result = zeros(size_mask(1), size_mask(2), 3);
    for i = 1: size_mask(1)
        for j = 1: size_mask(2)
            if(maskOut(i,j) >= lower_edge && maskOut(i,j) <= upper_edge)
                result(i,j,1) = img(i,j,1);
                result(i,j,2) = img(i,j,2);
                result(i,j,3) = maskOut(i,j,3);
            else
                result(i,j,1) = 0;
                result(i,j,2) = 0;
                result(i,j,3) = 0;
            end
        end
    end
    if(k+1 < hist_mask(2))
        lower_edge = upper_edge;
        upper_edge = edges(1,k+1);
    else
        lower_edge = upper_edge;
        upper_edge = max(edges);
    end
    figure(k+3);
    imshow(result);
end

