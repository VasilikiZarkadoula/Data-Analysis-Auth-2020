% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 2 Excerise 6
% Simulation of the central limit theorem

clc;
clear;

n = 100;
N = 10000;

x = zeros(n,1);
y = zeros(N,1);
for i = 1:N
    for j = 1:n
        x = unifrnd(0,1);
    end
    y(i) = mean(x);
end
histfit(y);
