% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 2 Excerise 2
% Generation of data from exponential distribution using the inverse from uniform.

clc;
clear;

n = 1000;
lamda = 1;
nbins = 20;

x = rand(n,1); % uniformly distributed random variables
y = -(1/lamda)*log(1-x); 

% Histogram of y and an exponential distribution fit
histfit(y,nbins);
