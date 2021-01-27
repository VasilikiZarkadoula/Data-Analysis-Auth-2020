% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 5 Excerise 1
% Correlation coefficient confidence interval and hypothesis testing

clc;
clear;
close all;

M = 1000;
n = 20;
m1 = 0;
m2 = 0;
m = [m1 m2];
s1 = 1;
s2 = 1;
ro = 0.5;
sigma1 = [s1^2 0; 0 s2^2];                  % for ro = 0
sigma2 = [s1^2 ro*s1*s2; ro*s1*s2 s2^2];    % for ro = 0.5
alpha = 0.05;

% a) compute 95% CI using Fisher transformation - check if 0,ro included
ro = [0 0.5];
flag = 0;

CorrelationCi1 = zeros(M,2);
CorrelationCi2 = zeros(M,2);
CorrelationCi3 = zeros(M,2,2);
roInCI = zeros(1,2);
zeroInCI =  zeros(1,2);
t = zeros(M,2);
pt = zeros(M,2);
p = zeros(M,2);
nullHypothesisTesting = zeros(2,1);
for i = 1:M
    % FIRST METHOD - analytical solution
        
    % Genrate Samples (1:ro=0, 2:ro=0.5) and compute Correlation Coefficients    
    samples1 = mvnrnd(m,sigma1,n);
    if flag
        samples1 = samples1.^2;
    end
    r1 = corrcoef(samples1);
  
    samples2 = mvnrnd(m,sigma2,n);
    if flag
        samples2 = samples2.^2;
    end
    r2 = corrcoef(samples2);
    
    % Fisher Transformation
    z1 = atanh(r1(1,2)) ;
    z2 = atanh(r2(1,2)) ;
    
    z95 = norminv(1-alpha/2);
    sZ = sqrt(1/(n-3));
    
    z1L = z1 - z95*sZ;
    z1U = z1 + z95*sZ;
    
    z2L = z2 - z95*sZ;
    z2U = z2 + z95*sZ;
    
    % Calculate CI of Correlation Coefficients
    CorrelationCi1(i,1) = (exp(2*z1L)-1)/(exp(2*z1L)+1);
    CorrelationCi1(i,2) = (exp(2*z1U)-1)/(exp(2*z1U)+1);
    CorrelationCi2(i,1) = (exp(2*z2L)-1)/(exp(2*z2L)+1);
    CorrelationCi2(i,2) = (exp(2*z2U)-1)/(exp(2*z2U)+1);
    
    % SECOND METHOD - corrcoef
    
    samples(:,:,1) = samples1;
    samples(:,:,2) = samples2;
    for j = 1:2
        [~,ptemp,rL,rU] = corrcoef(samples(:,:,j));
        p(i,j) = ptemp(1,2);
        CorrelationCi3(i,:,j) = [rL(1,2),rU(1,2)];
    
        % Check if real correlation coefficient is inside the CI    
        if( ro(j) > CorrelationCi3(i,1,j) && ro(j) < CorrelationCi3(i,2,j))
            roInCI(j) = roInCI(j) + 1;
        end
    end
    
%--------------------------------------------------------------------------
        
% b) null hypothesis testing
        
    % Check from Student distribution statistic t
    r = [r1(1,2) r2(1,2)];
    for j = 1:2
        t(i,j) = r(j)*sqrt((n-2)/(1-r(j)^2));
        pt(i,j) = 2*(1 - tcdf(t(i,j),n-2));
        if( pt(i,j) > 0.05 )
            nullHypothesisTesting(j) = nullHypothesisTesting(j) + 1;
        end    
    end
end
fprintf('p = 0 is included in the confidence interval: %0.3f%%\n',(roInCI(1)/M)*100);
fprintf('p = 0.5 is included in the confidence interval: %0.3f%%\n',(roInCI(2)/M)*100);

fprintf('\nHypothesis testing using Student distribution statistic t:\n');
fprintf('The hypothesis that the samples are not correlated for r0=0 is accepted %0.3f%%\n',(nullHypothesisTesting(1)/M)*100)
fprintf('The hypothesis that the samples are not correlated for r0=0.5 is accepted %0.3f%%\n',(nullHypothesisTesting(2)/M)*100)
 
%--------------------------------------------------------------------------

% Histograms
figure(1)
histogram(CorrelationCi1(:,1));
hold on;
histogram(CorrelationCi1(:,2));
title("Sample 1: correlation coefficient confidence interval")
legend("Lower bound","Upper bound")
hold off

figure(2)
histogram(CorrelationCi2(:,1))
hold on;
histogram(CorrelationCi1(:,2))
title("Sample 2: correlation coefficient confidence interval")
legend("Lower bound","Upper bound")
hold off
