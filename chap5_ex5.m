% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 5 Excerise 4
% Linear regression model , non parametric (bootstrap) confidence intervals

clc;
clear;

% import data
lightair = importdata('lightair.dat');
x = lightair(:,1);
y = lightair(:,2);

% 1. new bootstrap samples
bootSamples = bootstrp(100,@mean,lightair);

% 2. bo,b1 estimates
bootX = bootSamples(:,1);
bootY = bootSamples(:,2);
linearModel = fitlm(bootX,bootY); 
b = linearModel.Coefficients.Estimate;
b0 = b(1);
b1 = b(2);

% 3. repeat 1 and 2 1000 times
M = 100;
n = length(x);
alpha = 0.05;
b0Boot = zeros(M,1);
b1Boot = zeros(M,1);
for i = 1:M
    bootSamples = bootstrp(100,@mean,lightair);
    linearModel = fitlm(bootSamples(:,1),bootSamples(:,2)); 
    b = linearModel.Coefficients.Estimate;
    b0Boot(i) = b(1);
    b1Boot(i) = b(2);
end

% 4. confidence intervals for b0,b1
b0Boot = sort(b0Boot);
b1Boot = sort(b1Boot);
lowLim = round(M*alpha/2);
uppLim = round(M*(1-alpha/2));
b0bootCI = [b0Boot(lowLim) b0Boot(uppLim)];
b1bootCI = [b1Boot(lowLim) b1Boot(uppLim)];


