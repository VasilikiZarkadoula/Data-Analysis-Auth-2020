% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 2 Excerise 4
% Generation of uniform data and computation of the 1/E[x] and E[1/x]

clc;
clear;

n = [10 100 1000 10000]; 
N = categorical({'10','100','1000','10000'});
N = reordercats(N,{'10','100','1000','10000'});

m1 =  meanComparisons(1,2,n);
m2 =  meanComparisons(0,1,n);
m3 =  meanComparisons(-1,1,n);

% graphic comparison of 1/E[x] and E[1/x] for different values of (a,b)
figure(1)
bar(N,m1);
title('1/E[x](blue) vs E[1/X](orange) , continuous uniform distribution (1,2)');
xlabel('Number of iterations (n)');
figure(2)
bar(N,m2);
title('1/E[x](blue) vs E[1/X](orange) , continuous uniform distribution (0,1)');
xlabel('Number of iterations (n)');
figure(3)
bar(N,m3);
title('1/E[x](blue) vs E[1/X](orange) , continuous uniform distribution (-1,1)');
xlabel('Number of iterations (n)');


function m = meanComparisons(a,b,n)

mean1 = zeros(1,length(n));
mean2 = zeros(1,length(n));
for j = 1:length(n)
    for i = 1:n(j)
        %random numbers in (a,b) from continuous uniform distribution
        x = unifrnd(a,b);
    end
    mean1(j) = mean(x);     %E[x]
    mean2(j) = mean(1./x);  %E[1/x]
end

mean1_new = 1./mean1;   %1/E[x]
m = [mean1_new ; mean2]';
end

