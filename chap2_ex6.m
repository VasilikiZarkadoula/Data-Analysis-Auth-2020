% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 2 Excerise 6
% Simulation of the central limit theorem

clc;
clear;

n = 100;
N = 10000;

samples = zeros(n,1);
m = zeros(N,1);
% Generate samples from uniform distribution 
for i = 1:N
    for j = 1:n
        samples = unifrnd(0,1);
    end
    m(i) = mean(samples);
end
% Plot means of x and normal distribution curve
histfit(m);
