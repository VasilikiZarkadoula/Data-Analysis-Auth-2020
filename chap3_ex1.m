% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 3 Excerise 1
% Simulation of the distribution of the mean 
% Poisson distribution 

clc;
clear;

%a) show that the mle estimator of lamda is the mean value of the samples

    % random choise of lamda and n
lamda = 5;  
n = 10000;

    % first method
x = zeros(1,n);
for i=1:n
    x(i) = poissrnd(lamda);
end
m = mean(x);
fprintf('lamda = %i and mean(samples) = %3f\n',lamda,m);

    % second method
ml = mle(x,'distribution','poiss');
fprintf('lamda = %i and mle result = %3f\n',lamda,ml);

%--------------------------------------------------------------------------

%b) create M poisson samples of size n and compute the mean of each sample

M = 1000;
n = 10;
lamda = 7;
average = mean_Poisson(lamda,M,n);

function avrg = mean_Poisson(lamda,samples,size)
x = zeros(samples,size);
for i=1:samples
    for j=1:size
         x(i,j) = poissrnd(lamda);
    end
end

m = mean(x,2);
avrg = mean(m);

figure;
h = histogram(m);
    % check if center of histogram is lamda
lim = h.BinLimits;
center = (lim(1) + lim(2))/2;
hold on
plot([center center],ylim,'r');
hold off
end


