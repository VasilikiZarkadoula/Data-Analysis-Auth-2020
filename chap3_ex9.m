% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 3 Excerise 9
% Comparison of percentile bootstrap and parametric confidence interval of
% mean difference

clc;
clear;
close all;

M = 100;
n = 10;
m = 12;
B = 1000;
flag = 0;       % if 1 do x^2 and y^2, if 2 do y~N(0.2,1)
alpha = 0.05;

% M random samples of size n from the standard normal distribution
% M random samples of size m from the standard normal distribution
x = randn(n,M);
y = randn(m,M);
if flag == 1
    x = x.^2;
    y = y.^2;
elseif flag == 2
    y = 0.2+1*randn(m,M);
end

% compute 95% parametric CI and 95% percentile bootstrap CI of mean
% difference for every sample
[~,~,CI,~] = ttest2(x,y); %i) parametric ci 

lowerLim = (B+1)*alpha/2;
upperLim = B+1-lowerLim;
limits = [lowerLim upperLim]/B*100;
bootstrXmean = bootstrp(B,@mean,x);
bootstrYmean = bootstrp(B,@mean,y);
bootMeanDiff = bootstrXmean - bootstrYmean;
bootCI = prctile(bootMeanDiff,limits);

% graphic comparison of the two confidence intervals
figure;
bar(CI(1,:));
hold on
bar(bootCI(1,:),'r');
title('Lower Boundries of confidence intervals of mean difference')
legend('Parametric','Bootstrap')
xlabel('Samples')
hold off

figure;
bar(CI(2,:));
hold on
bar(bootCI(2,:),'r');
title('Upper Boundries of confidence intervals of mean difference')
legend('Parametric','Bootstrap')
xlabel('Samples')
hold off

parDiff = find(CI(1,:)<0 & CI(2,:)>0);
bootDiff = find(bootCI(1,:)<0 & bootCI(2,:)>0);
fprintf('Probability of mean(x),mean(y) being different (parametric ci) = %1.3f \n',length(parDiff)/M); 
fprintf('Probability of mean(x),mean(y) being different (percentile bootstrap ci) = %1.3f \n',length(bootDiff)/M); 
