row_min = 100000000;
col_min = 100000000;

myFiles = dir(fullfile('S','*.jpg'));
myMasks = dir(fullfile('s_mask','*.jpg'));
for k = 1:length(myFiles);
    i = imread(strcat('S/', myFiles(k).name));
    s = size(i);
    if s(1) < row_min
        row_min = s(1);
    end
    if s(2) < col_min
        col_min = s(2);
    end
end
disp(row_min);
disp(col_min);

for k = 1:length(myFiles)
    i = imread(strcat('S/', myFiles(k).name));
    i = imresize(i, [row_min col_min]);
    imwrite(i, strcat('S/', myFiles(k).name));
end

for k = 1:length(myMasks)
    i = imread(strcat('s_mask/', myMasks(k).name));
    i = imresize(i, [row_min col_min]);
    imwrite(i, strcat('s_mask/', myMasks(k).name));
end