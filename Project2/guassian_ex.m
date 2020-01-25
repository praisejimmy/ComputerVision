%digital implementation of Gaussian filter
close all

x=[-10:0.1:10];
sigma=1;
px=1/(sqrt(2*pi)*sigma)*exp(-x.^2/(2*sigma^2));
plot(x,px)
title('Gaussian distribution with mean=0, sigma=1')

Gy=[0.05399 0.242 0.3989 0.242 0.05399]';
Gx=Gy';

GaussianFilter=Gy*Gx

normalizing_factor=sum(sum(GaussianFilter));
NormalizedGaussianFilter=GaussianFilter/normalizing_factor

%fspecial('gaussian',5,1)
%fspecial('gaussian',5)