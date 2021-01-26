% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 2 Excerise 4
% Generation of uniformly distributed data and computation of the 1/E[x] and E[1/x]
% Check if 1/E[x] = E[1/x]

close all;
clc;
clear;

n = [10 100 500 1000 5000 10000]; 
N = categorical(n);

m1 =  meanComparisons(1,2,n);
m2 =  meanComparisons(0,1,n);
m3 =  meanComparisons(-1,1,n);

% graphic comparison of 1/E[x] and E[1/x] for different values of (a,b)
figure(1)
bar(N,m1);
legend('1/E[x]','E[1/X]')
xlabel('Number of iterations (n)');

figure(2)
bar(N,m2);
legend('1/E[x]','E[1/X]')
xlabel('Number of iterations (n)');

figure(3)
bar(N,m3);
legend('1/E[x]','E[1/X]')
xlabel('Number of iterations (n)');


function m = meanComparisons(a,b,n)

mean1 = zeros(1,length(n));
mean2 = zeros(1,length(n));
for j = 1:length(n)
    for i = 1:n(j)
        %random numbers in interval (a,b) from continuous uniform distribution
        x = unifrnd(a,b);
    end
    mean1(j) = mean(x);     %E[x]
    mean2(j) = mean(1./x);  %E[1/x]
end

mean1new = 1./mean1;   %1/E[x]
m = [mean1new ; mean2]';
end

