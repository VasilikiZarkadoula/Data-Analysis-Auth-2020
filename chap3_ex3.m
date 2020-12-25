% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 3 Excerise 3
% Simulation of the confidence interval(CI) estimation of the mean of the 
% exponential distribution 

clc;
clear;

alpha = 0.05;

% create sample of size n, compute 95% CI
mu = 15;
n = 100;  
x = zeros(1,n);
for i=1:n
    x(i) = exprnd(mu);
end

    % first method - 95% CI
sem = std(x)/sqrt(n);                % Standard Error
ts = tinv([alpha/2  1-alpha/2],n-1); % T-Score
ci = mean(x) + ts*sem;               % Confidence Intervals

    % Second method - 95% CI : ttest
[~,~,ci2,~] = ttest(x);

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
mu = 3;
TS = tinv([alpha/2  1-alpha/2],s-1); 

y = zeros(M,s);
SEM = zeros(1,M);
CI = zeros(M,2);
counter = 0;
for i=1:M
    for j=1:s
       y(i,j) = exprnd(mu);
    end
    SEM(i) = std(y(i,:))/sqrt(s);               
    CI(i,:) = mean(y(i,:)) + TS*SEM(i);  
    
    if CI(i,1)<mu && CI(i,2)>mu
        counter = counter+1;
    end
end

perc = (counter/M)*100;
fprintf('mu = %i is included in the confidence interval for the %0.2f%% of the samples\n',mu,perc);




    
