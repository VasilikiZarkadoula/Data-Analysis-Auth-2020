% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 5 Excerise 5
% Linear regression model , non parametric (bootstrap) confidence intervals

clc;
clear;

% import data
lightair = importdata('lightair.dat');
n = length(lightair);

% 1. new bootstrap samples
bootSamples = lightair(unidrnd(n,n,1), :);

% 2. bo,b1 estimates
linearModel = fitlm(bootSamples(:,1),bootSamples(:,2)); 
b = linearModel.Coefficients.Estimate;
b0 = b(1);
b1 = b(2);

% 3. repeat 1 and 2 1000 times
M = 1000;
alpha = 0.05;

b0Bootstrap = zeros(M,1);
b1Bootstrap = zeros(M,1);
for i = 1:M
    bootSamples = lightair(unidrnd(n,n,1), :);
    linearModel = fitlm(bootSamples(:,1),bootSamples(:,2)); 
    b = linearModel.Coefficients.Estimate;
    b0Bootstrap(i) = b(1);
    b1Bootstrap(i) = b(2);
end

% 4. non- parametric confidence intervals for b0,b1
b0Bootstrap = sort(b0Bootstrap);
b1Bootstrap = sort(b1Bootstrap);
lowLim = round(M*alpha/2);
uppLim = round(M*(1-alpha/2));

b0bootCI = [b0Bootstrap(lowLim) b0Bootstrap(uppLim)];
b1bootCI = [b1Bootstrap(lowLim) b1Bootstrap(uppLim)];
fprintf('Non-Parametric CI of bo = [%2.3f %2.3f] \n',b0bootCI(1,:));
fprintf('Non-Parametric CI of b1 = [%2.3f %2.3f] \n',b1bootCI(1,:));

% percentiles = [5/2 100-5/2];
% b0CI = prctile(b0Bootstrap,percentiles);
% b1CI = prctile(b1Bootstrap,percentiles);

% parametric confidence intervals for b0,b1
% Parametrical
X = lightair(:,1);
Y = lightair(:,2);
regressionModel = fitlm(X,Y);
ci = coefCI(regressionModel);
fprintf('\nParametric CI of bo = [%2.3f %2.3f] \n',ci(1,:));
fprintf('Parametric CI of b1 = [%2.3f %2.3f] \n',ci(2,:));
