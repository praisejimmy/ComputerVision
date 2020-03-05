close all

%image = imread("t6.jpg");

%[L, centers] = imsegkmeans(image, 7);
%B = labeloverlay(image,L);
%imshow(B)
%title('Labeled Image')



img=imread('t1.jpg');
[maskOut]=kGaussian_color_EM(img,4);
figure(1);  
imshow(maskOut);
imwrite(maskOut, "t1_em_k4.jpg");