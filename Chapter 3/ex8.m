% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 3 Excerise 8
% Comparison of percentile bootstrap and parametric confidence interval of
% standard deviation

clc;
clear;
close all;

n = 10;
M = 100;
B = 1000;
flag = 1; % If 1 do x^2
alpha = 0.05;

% M random samples of size n from the standard normal distribution
x = randn(n,M);
if flag
    x = x.^2;
end

% compute 95% parametric CI and 95% percentile bootstrap CI of standard  
% deviation for every sample
[~,~,CI,~] = vartest(x,1);              % 1 is random
CI = sqrt(CI);                          % parametric ci 

bootstrXstd = bootstrp(B,@std,x);
lowerLim = (B+1)*alpha/2;
upperLim = B+1-lowerLim;
limits = [lowerLim upperLim]/B*100;
bootCI = prctile(bootstrXstd,limits,1); %ii) percentile bootstrap ci 


% graphic comparison of the two confidence intervals
bar(CI(1,:));
hold on
bar(bootCI(1,:),'r');
title('Lower Boundries of confidence intervals of std')
legend('Parametric','Bootstrap')
xlabel('Samples')
hold off

figure;
bar(CI(2,:));
hold on
bar(bootCI(2,:),'r');
title('Upper Boundries of confidence intervals of std')
legend('Parametric','Bootstrap')
xlabel('Samples')
hold off
