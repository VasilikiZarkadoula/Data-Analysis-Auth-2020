% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 3 Excerise 2
% Repeat exercise 1 but for the exponential distribution

clc;
clear;

%a) show that the mle estimator of samples is equal to the mean value of 
% the samples

 % random choise of mu and n
mu = 1; 
n = 10000;  

    % first method
samples = exprnd(mu,n,1);
m = mean(samples);
fprintf('mu = %i and mean(samples) = %3f\n',mu,m);

    % second method
ml = mle(samples,'distribution','exp');
fprintf('mu = %i and mle result = %3f\n',mu,ml);

if( abs(m - ml) < 0.0001 )
    fprintf('mle(samples) = mean(samples)\n');
end

%--------------------------------------------------------------------------

%b)

M = 10000;
n = 500;
mu = 4;
average = meanExponential(mu,M,n);
fprintf('\nmu = %0.3f\n',mu);
fprintf('Average = %0.3f\n',average);

function avrg = meanExponential(mu,numOfSamples,sizeOfSamples)

samples = exprnd(mu,sizeOfSamples,numOfSamples);
m = mean(samples,2);
avrg = mean(m);

figure;
h = histogram(m);
hold on
% check if center of histogram is mu
lim = h.BinLimits;
center = (lim(1) + lim(2))/2;
p1 = plot([center center],ylim,'r');
hold on
p2 = plot([mu mu],ylim,'y');
title('Histogram of the mean values of samples from Poisson distribution')
legend([p1 p2],{'Histogram Center','mu'})
hold off

if( abs(center - mu) < 0.001 )
    fprintf('\nHistogram center = mu = %i\n',mu);
else
    fprintf('\nHistogram center not equal to lamda\n');
end
end


