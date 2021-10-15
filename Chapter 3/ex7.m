% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 3 Excerise 7
% Comparison of percentile bootstrap and parametric confidence interval of
% mean

clc;
clear;
close all;

n = 10;
M = 100;
B = 1000;
flag = 0; % If 1 do x^2
alpha = 0.05;

% M random samples of size n from the standard normal distribution
x = randn(n,M);
if flag
    x = x.^2;
end

% compute 95% parametric CI and 95% percentile bootstrap CI of mean 
% for every sample

[~,~,CI,~] = ttest(x);                     %i) parametric ci

bootstrXmean = bootstrp(B,@mean,x);
lowerLim = (B+1)*alpha/2;
upperLim = B+1-lowerLim;
limits = [lowerLim upperLim]/B*100;
bootCI = prctile(bootstrXmean,limits,1);  %ii) percentile bootstrap ci

% graphic comparison of the two confidence intervals
bar(CI(1,:));
hold on
bar(bootCI(1,:),'r');
title('Lower Boundries of confidence intervals')
legend('Parametric','Bootstrap')
xlabel('Samples')
hold off

figure;
bar(CI(2,:));
hold on
bar(bootCI(2,:),'r');
title('Upper Boundries of confidence intervals')
legend('Parametric','Bootstrap')
xlabel('Samples')
hold off



