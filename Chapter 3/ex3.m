% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 3 Excerise 3
% Simulation of the confidence interval(CI) estimation of the mean of the 
% exponential distribution 

clc;
clear;

% create sample of size n, compute 95% CI
mu = 15;
n = 100;  
sample = exprnd(mu,n,1);

    % first method - 95% CI
alpha = 0.05;
sem = std(sample)/sqrt(n);                % Standard Error
ts = tinv([alpha/2  1-alpha/2],n-1);      % T-Score
ci = mean(sample) + ts*sem;               % Confidence Interval

    % Second method - 95% CI : ttest
[~,~,ci2,~] = ttest(sample);

% check if mu is included in ci
formatSpec1 = 'Confidence interval [%0.3f %0.3f] includes mu = %i\n';
formatSpec2 = 'Confidence interval [%0.3f %0.3f] does not include mu = %i\n';
if mu>ci(1) && mu<ci(2)
    fprintf(formatSpec1,ci(1),ci(2),mu);
else
    fprintf(formatSpec2,ci(1),ci(2),mu);
end

%--------------------------------------------------------------------------

% create M samples of size s, compute 95% CI
M = 1000; 
s = 100;  
mu = 15;

samples = exprnd(mu,s,M);
[~,~,CI,~] = ttest(samples);

counter = 0;
for i =1:M
    if CI(1,i)<mu && CI(2,i)>mu
        counter = counter+1;
    end
end

percentage = (counter/M)*100;
fprintf('\nmu = %i is included in the confidence interval for the %0.2f%% of the samples\n',mu,percentage);

