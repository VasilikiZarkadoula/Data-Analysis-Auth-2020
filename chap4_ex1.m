% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 4 Excerise 1
% Uncertainty in the coefficient of restitution and propagation of error
% of the height after bouncing to the error of the coefficient of
% restitution.

clc;
clear;

%a) 
h1 = 100;                   % height of free fall of a ball
h2 = [60, 54, 58, 60, 56];  % heights after bouncing

eActual = 0.76;
eEstim = sqrt(h2/h1);
n = length(eEstim);
eEstimMean = mean(eEstim);
eEstimStd = std(eEstim);
eEstimSd = eEstimStd / sqrt(n); 

alpha = 0.05;
tcrit = tinv(1-alpha/2,n-1); 

% Uncertainty of Measurement and random uncertainty limit
pr1 = [eActual-eEstimStd eActual+eEstimStd];
fprintf('Precision of CoR for one throw: \n \t e +- std_e = %2.3f +- %2.3f \n',eActual,eEstimStd);
pr2 = [eActual-tcrit*eEstimStd eActual+tcrit*eEstimStd];
fprintf('Precision limit of CoR for one throw: \n \t e +- t{%d,1-%1.2f/2}*std_e = %2.3f +- %2.3f * %2.3f = %2.3f +- %2.3f \n',...
    n-1,alpha,eActual,tcrit,eEstimStd,eActual,tcrit*eEstimStd);
% Uncertainty of Measurement and random uncertainty limit for the mean
pr3 = [eEstimMean-eEstimSd eEstimMean+eEstimSd];
fprintf('Precision of mean CoR: \n \t mean +- SD(mean) = %2.3f +- %2.3f / sqrt(%d) = %2.3f +- %2.3f \n',...
    eEstimMean,eEstimStd,n,eEstimMean,eEstimSd);
pr4 = [eEstimMean-tcrit*eEstimSd eEstimMean+tcrit*eEstimSd];
fprintf('Precision limit of mean CoR: \n \t mean +- t{%d,1-%1.2f/2}*SD(mean) = %2.3f +- %2.3f * %2.3f = %2.3f +- %2.3f \n',...
    n-1,alpha,eEstimMean,tcrit,eEstimSd,eEstimMean,tcrit*eEstimSd);

%--------------------------------------------------------------------------

%b)
M = 1000;
mu2 = 58;
sigma2 = 2;
h2 = normrnd(mu2, sigma2, n, M);

meanH2 = mean(h2);
stdH2 = std(h2);
eb = sqrt(h2./h1);
meanE = mean(eb);
stdE = std(eb);

eActual = sqrt(mu2 / h1);
diff = abs(meanE - eActual);
figure(1);
histogram(meanE);
hold on
p = plot([eActual eActual],ylim,'r');
xlabel('Values of coefficient of restitution from 1000 experiments')
ylabel('Probability')
legend(p,'actual coefficient of restitution')
hold off

%--------------------------------------------------------------------------

%c)
h1 = [80 100 90 120 95];
h2 = [48 60 50 75 56];

% Uncertainty : heights
h1Std = std(h1);
h2Std = std(h2);

% Uncertainty : coefficient of restitution
e = sqrt(h2./h1);
eStd = std(e);

% hypothesis test : e = 0.76
h = ttest(e,0.76);
if h == 1
    fprintf('\nHypothesis that e = 0.76 is rejected\n')
else
    fprintf('\nHypothesis that e = 0.76 is accepted\n')
end




