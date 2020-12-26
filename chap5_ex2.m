% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 5 Excerise 2
% Randomization check , null hypothesis testing

clc;
clear;

L = 1000;
n = 20;
mx = 0;
my = 0;
m = [mx my];
sx = 1;
sy = 1;
ro = [0 0.5];
sigma1 = [sx^2 0; 0 sy^2];
sigma2 = [sx^2 ro(2)*sx*sy; ro(2)*sx*sy sy^2];
alpha = 0.05;
lowLim = round((alpha/2)*L);
uppLim = round((1-alpha/2)*L);

[t0,t] = NullHypothesis(m,sigma1,n,L);
tL = sort(t);
tLow = tL(lowLim);
tUpp = tL(uppLim);
if t0>tLow && t0<tUpp
    fprintf('Null hypothesis for ro=0 accepted\n')
else
    fprintf('Null hypothesis for ro=0 rejected\n')
end

[t02,t2] = NullHypothesis(m,sigma2,n,L);
tL2 = sort(t2);
tLow2 = tL2(lowLim);
tUpp2 = tL2(uppLim);
if t02>tLow2 && t02<tUpp2
    fprintf('Null hypothesis for ro=0.5 accepted\n')
else
    fprintf('Null hypothesis for ro=0.5 rejected\n')
end


function [t0,t] = NullHypothesis(mean,sigma,size,L)
samples = mvnrnd(mean,sigma,size);
r = corrcoef(samples);
r = r(1,2);
t0 = r*sqrt((size-2)/(1-r^2));
t = zeros(L,1);
for i = 1:L
    for j = 1:2
        perm = randperm(size);
        samples(:,j) = samples(perm);
    end
    r2 = corrcoef(samples);
    r2 = r2(1,2);
    t(i) = r2*sqrt( (size-2)/(1-r2^2) );
end
end

