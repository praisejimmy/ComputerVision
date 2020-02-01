clc
close all

correct = 0;

im = imread('rock_far.jpg');
result = rps(im);
fprintf('\nExpected answer: rock');
fprintf('\nanswer: %s\n', result);
if strcmp(result, 'rock')
    correct = correct + 1;
end 

im = imread('rock_close.jpg');
result = rps(im);
fprintf('\nExpected answer: rock');
fprintf('\nanswer: %s\n', result);
if strcmp(result, 'rock')
    correct = correct + 1;
end 

im = imread('scissors_medium.jpg');
result = rps(im);
fprintf('\nExpected answer: scissors');
fprintf('\nanswer: %s\n', result);
if strcmp(result, 'scissors')
    correct = correct + 1;
end 

im = imread('paper_medium.jpg');
result = rps(im);
fprintf('\nExpected answer: paper');
fprintf('\nanswer: %s\n', result);
if strcmp(result, 'paper')
    correct = correct + 1;
end 

im = imread('scissors_close.jpg');
result = rps(im);
fprintf('\nExpected answer: scissors');
fprintf('\nanswer: %s\n', result);
if strcmp(result, 'scissors')
    correct = correct + 1;
end 

im = imread('paper_close.jpg');
result = rps(im);
fprintf('\nExpected answer: paper');
fprintf('\nanswer: %s\n', result);
if strcmp(result, 'paper')
    correct = correct + 1;
end 

im = imread('rock_medium.jpg');
result = rps(im);
fprintf('\nExpected answer: rock');
fprintf('\nanswer: %s\n', result);
if strcmp(result, 'rock')
    correct = correct + 1;
end 

im = imread('scissors_medium.jpg');
result = rps(im);
fprintf('\nExpected answer: scissors');
fprintf('\nanswer: %s\n', result);
if strcmp(result, 'scissors')
    correct = correct + 1;
end 
fprintf('Correct: %d/8\n', correct);
