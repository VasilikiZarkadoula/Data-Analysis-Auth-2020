% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 3 Excerise 1
% Simulation of the distribution of the mean 
% Poisson distribution 

close all;
clc;
clear;

%a) show that the mle estimator of samples is equal to the mean value of 
% the samples

    % random choise of lamda and n
lamda = 5;  
n = 10000;

    % first method
samples = poissrnd(lamda,n,1);
m = mean(samples);
fprintf('lamda = %i and mean(samples) = %3f\n',lamda,m);

    % second method
ml = mle(samples,'distribution','poiss');
fprintf('lamda = %i and mle(samples) = %3f\n',lamda,ml);

if( abs(m - ml) < 0.0001 )
    fprintf('mle(samples) = mean(samples)\n');
end


%--------------------------------------------------------------------------

%b) create M poisson samples of size n and compute the mean of each sample

M = 1000;
n = 10;
lamda = 2;
average = meanPoisson(lamda,M,n);
fprintf('\nLamda = %0.3f\n',lamda);
fprintf('Average = %0.3f\n',average);

function avrg = meanPoisson(lamda,numOfSamples,sizeOfSamples)

samples = poissrnd(lamda,sizeOfSamples,numOfSamples);
m = mean(samples,2);
avrg = mean(m);

figure;
h = histogram(m);
hold on
% check if center of histogram is lamda
lim = h.BinLimits;
center = (lim(1) + lim(2))/2;
p1 = plot([center center],ylim,'r');
hold on
p2 = plot([lamda lamda],ylim,'y');
title('Histogram of the mean values of samples from Poisson distribution')
legend([p1 p2],{'Histogram Center','Lamda'})
hold off

if( abs(center - lamda) < 0.001 )
    fprintf('\nHistogram center = lamda = %i\n',lamda);
else
    fprintf('\nHistogram center not equal to lamda\n');
end

end
