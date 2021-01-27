% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 3 Excerise 10
% Statistical test for equal means using percentile bootstrap and
% random permutation (randomization) along with the parametric test.

clc;
clear;
close all;

M = 100;
n = 10;
m = 12;
B = 1000;
alpha = 0.05;

% M random samples of size n from the standard normal distribution
% M random samples of size m from the standard normal distribution
x = normrnd(0,1,[M n]);
y = normrnd(0,1,[M m]);

lowerLim = (B+1)*alpha/2;
upperLim = B+1-lowerLim;
limits = [lowerLim upperLim]/B*100;
limits(1) = ceil(limits(1));
limits(2) = floor(limits(2));

%--------------------------------------------------------------------------

% parametric test
counter = 0;
h = zeros(M,1);
for i = 1:M
    h(i) = ttest2(x(i,:),y(i,:));
    if h(i) == 1
        counter = counter +1;
    end
end
fprintf('Parametric test:\n')
fprintf('The hypothesis mean(x) = mean(y) rejected : %0.2f%%\n',counter/M);

%--------------------------------------------------------------------------

% percentile bootstrap test
resultB = zeros(M,1);
BootmeanDiff = zeros(B+1,1);
for i = 1:M
    bootstrXmean = bootstrp(B,@mean,x(i,:));
    bootstrYmean = bootstrp(B,@mean,y(i,:));
    BootMeanDiff = bootstrXmean - bootstrYmean;

    diff = mean(x(i,:)) - mean(y(i,:));
    BootmeanDiff = [BootMeanDiff; diff];
    BootmeanDiff = sort(BootmeanDiff);
    rankB = find(BootmeanDiff == diff);
    if( rankB < limits(1) || rankB > limits(2) )
        resultB(i) = 1;
    end
end
fprintf('\nBootstrap test:\n')
fprintf('The hypothesis mean(x) = mean(y) rejected : %0.2f%%\n',sum(resultB)/M);

%--------------------------------------------------------------------------

% random permutation test
result = zeros(M,1);
PermMeanDiff = zeros(B+M,1);
for i=1:M
    bootstrXY = [x(i,:) y(i,:)];
    for j=1:B
        perm = randperm(n+m);
        xPerm = bootstrXY(perm(1:n));
        yPerm = bootstrXY(perm(n+1:end));
        PermMeanDiff(j) = mean(xPerm)-mean(yPerm);
    end
    diff = mean(x(i,:)) - mean(y(i,:));
    PermMeanDiff = [PermMeanDiff; diff];
    PermMeanDiff = sort(PermMeanDiff);
    rank = find(PermMeanDiff == diff);
    if( rank < limits(1) || rank > limits(2) )
        result(i) = 1;
    end
end
fprintf('\nPermutation test:\n')
fprintf('The hypothesis mean(x) = mean(y) rejected : %0.2f%%\n',sum(result)/M);



