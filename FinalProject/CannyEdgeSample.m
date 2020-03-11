%testing the effects of parameters in Canny edge detector

%varying sigma
I = imread('./PlateSamples/ca1635.png');
I = rgb2gray(I);
for s=0.5:0.5:5
    s
    E=edge(I,'canny',[],s);
    imshow(E)
    pause
end

%varying threshold
for tHigh=0.05:0.05:0.4
    tHigh
    E=edge(I,'canny',[0.4*tHigh tHigh],1.5);
    imshow(E)
    pause
end