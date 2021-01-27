% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 3 Excerise 4
% Data from voltage dropout in an electric circuit.
% Estimation and hypothesis testing on mean, variance and hypothesis
% testing for goodness of fit to normal distribution.

clc;
clear;

sample = [41 46 47 47 48 50 50 50 50 50 50 50 48 50 50 50 50 50 50 50 52 52 53 55 50 50 50 50 52 52 53 53 53 53 53 57 52 52 53 53 53 53 53 53 54 54 55 68];
variance = var(sample);
meanValue = mean(sample);

%a) compute 95% CI of variance of x
[~,~,ci1,~] = vartest(sample,variance);
formatSpec1 = 'Confidence interval [%0.3f %0.3f] includes var(x) = %0.3f\n';
formatSpec2 = 'Confidence interval [%0.3f %0.3f] does not include var(x) = %0.3f\n';
if variance>ci1(1) && variance<ci1(2)
    fprintf(formatSpec1,ci1(1),ci1(2),variance);
else
    fprintf(formatSpec2,ci1(1),ci1(2),variance);
end

%b) check the hypothesis that 5 is the standard deviation of the sample
standardDev = 5;
v = standardDev^2;
[h2,~,~,~] = vartest(sample,v);
if h2 == 1
    fprintf('\nThe hypothesis that std = 5 is rejected at a 5%% significance level\n');
else
    fprintf('\nThe hypothesis that std = 5 is accepted at a 5%% significance level\n');
end

%c) compute 95% CI of mean of x
[~,~,ci3,~] = ttest(sample);
formatSpec11 = '\nConfidence interval [%0.3f %0.3f] includes mean(x) = %0.3f\n';
formatSpec22 = '\nConfidence interval [%0.3f %0.3f] does not include mean(x) = %0.3f\n';
if meanValue>ci3(1) && meanValue<ci3(2)
    fprintf(formatSpec11,ci3(1),ci3(2),meanValue);
else
    fprintf(formatSpec2,ci3(1),ci3(2),meanValue);
end

%d) check the hypothesis that 52 is the mean value of the sample
[h4,~,~,~] = ttest(sample,52);
if h4 == 1
    fprintf('\nThe hypothesis that mean = 52 is rejected at a 5%% significance level\n');
else
    fprintf('\nThe hypothesis that mean = 52 is accepted at a 5%% significance level\n');
end

%e) normal distribution goodness-of-fit test 
[h5,p5] = chi2gof(sample);
if h5 == 1
    fprintf('\nThe hypothesis that the normal distibuton fits to the samples is rejected at a 5%% significance level\n');
else
    fprintf('\nThe hypothesis that the normal distibuton fits to the samples is accepted at a 5%% significance level\n');
end

fprintf('\np-value (for H:normal fit) = %1.5f \n',p5);

