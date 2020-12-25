% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 3 Excerise 6
% Bootstrap estimate of standard error of sample mean

clc;
clear;

n = 10;
B = 1000;
flag = 0; % If 1 apply exponential transform 

% random sample of size n from the standard normal distribution
x = randn(n,1);
if flag
    x = exp(x);
end
meanX = mean(x);
stdX = std(x);

%--------------------------------------------------------------------------

%a) B bootstrap samples and mean value

    % first method
bootstrX = zeros(n,B);
positions = zeros(n,B);
for i=1:B
    positions(:,i) = randi(n,n,1);
    bootstrX(:,i) = x(positions(:,i));
end
bootstrXmean = mean(bootstrX);

    % second method
bootstrXmean2 = bootstrp(B,@mean,x);

histogram(bootstrXmean2);
hold on
plot([meanX meanX],ylim,'r')
title(sprintf('B=%d bootstrap means for sample of size n=%d',B,n))
hold off

%--------------------------------------------------------------------------

%b) standard error of mean x and of bootstrap mean
seX = stdX/sqrt(n);
seBootstrX = std(bootstrXmean2); 
fprintf('Standard error of sample mean = %1.3f \n', seX);
fprintf('Standard error of bootstrap samples mean = %1.3f \n', seBootstrX);

