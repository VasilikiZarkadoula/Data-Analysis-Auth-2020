% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 3 Excerise 2
% Repeat exercise 1 but for the exponential distribution

clc;
clear;

%a)

 % random choise of mu and n
mu = 1; 
n = 10000;  

    % first method
x = zeros(1,n);
for i=1:n
    x(i) = exprnd(mu);
end
m = mean(x);
fprintf('mu = %i and mean(samples) = %3f\n',mu,m);

    % second method
ml = mle(x,'distribution','exp');
fprintf('mu = %i and mle result = %3f\n',mu,ml);

%--------------------------------------------------------------------------

%b)

M = 5000;
n = 500;
mu = 4;
average = mean_Exponential(mu,M,n);

function avrg = mean_Exponential(mu,samples,size)
x = zeros(samples,size);
for i=1:samples
    for j=1:size
         x(i,j) = exprnd(mu);
    end
end
m = mean(x,2);
avrg = mean(m);

figure;
h = histogram(m);
    % check if center of histogram is mu
lim = h.BinLimits;
center = (lim(1) + lim(2))/2;
hold on
plot([center center],ylim,'r');
hold off
end


