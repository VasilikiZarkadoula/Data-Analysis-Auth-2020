% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 5 Excerise 1
% Correlation coefficient confidence interval and hypothesis testing

clc;
clear;

M = 1000;
n = 20;
mx = 0;
my = 0;
m = [mx my];
sx = 1;
sy = 1;
ro = 0.5;
sigma1 = [sx^2 0; 0 sy^2]; % for ro = 0
sigma2 = [sx^2 ro*sx*sy; ro*sx*sy sy^2];
alpha = 0.05;

% a) compute 95% CI using Fisher transformation - check if 0,ro included
 
CorrelationCi_1 = zeros(M,2,2);
CorrelationCi_2 = zeros(M,2,2);
roInCI = zeros(1,2);
zeroInCI =  zeros(1,2);
ro = [0 0.5];

t = zeros(M,2);
pt = zeros(M,2);
p = zeros(M,2);
nullHypothesisTesting = zeros(2,1);

for i = 1:M
    % FIRST METHOD - analytical solution
        
    % Genrate Samples (1:ro=0, 2:ro=0.5) and compute Correlation Coefficients    
    samples1 = mvnrnd(m,sigma1,n);
    %samples1 = samples1.^2;
    r1 = corrcoef(samples1);
  
    samples2 = mvnrnd(m,sigma2,n);
    %samples2 = samples2.^2;
    r2 = corrcoef(samples2);
    
    % Fisher Transformation
    z1 = atanh(r1(1,2)) ;
    z2 = atanh(r2(1,2)) ;
    
    z95 = norminv(1-alpha/2);
    sz = sqrt(1/(n-3));
    
    z1L = z1 - z95*sz;
    z1U = z1 + z95*sz;
    
    z2L = z2 - z95*sz;
    z2U = z2 + z95*sz;
    
    % Calculate CI of Correlation Coefficients
    CorrelationCi_1(i,1,1) = (exp(2*z1L)-1)/(exp(2*z1L)+1);
    CorrelationCi_1(i,2,1) = (exp(2*z1U)-1)/(exp(2*z1U)+1);
    CorrelationCi_1(i,1,2) = (exp(2*z2L)-1)/(exp(2*z2L)+1);
    CorrelationCi_1(i,2,2) = (exp(2*z2U)-1)/(exp(2*z2U)+1);
    
        % SECOND METHOD - corrcoef
    samples(:,:,1) = samples1;
    samples(:,:,2) = samples2;
    for j = 1:2
        [~,ptemp,rL,rU] = corrcoef(samples(:,:,j));
        p(i,j) = ptemp(1,2);
        CorrelationCi_2(i,:,j) = [rL(1,2),rU(1,2)];
    
        % Check if real correlation coefficient is inside the CI    
        if( ro(j) > CorrelationCi_2(i,1,j) && ro(j) < CorrelationCi_2(i,2,j))
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
fprintf('Hypothesis testing using confidence intervals:\n');
fprintf('The hypothesis that the samples are not correlated for r0=0 is accepted %0.3f%%\n',(roInCI(1)/M)*100)
fprintf('The hypothesis that the samples are not correlated for r0=0.5 is accepted %0.3f%%\n',(roInCI(2)/M)*100)
fprintf('\nHypothesis testing using Student distribution statistic t:\n');
fprintf('The hypothesis that the samples are not correlated for r0=0 is accepted %0.3f%%\n',(nullHypothesisTesting(1)/M)*100)
fprintf('The hypothesis that the samples are not correlated for r0=0.5 is accepted %0.3f%%\n',(nullHypothesisTesting(2)/M)*100)
 
%--------------------------------------------------------------------------

% Histograms
figure(1)
histogram(CorrelationCi_1(:,1,1));
hold on;
histogram(CorrelationCi_1(:,2,1));
title("Sample 1: correlation coefficient confidence interval")
legend("Lower bound","Upper bound")

figure(2)
histogram(CorrelationCi_1(:,1,2))
hold on;
histogram(CorrelationCi_1(:,2,2))
title("Sample 2: correlation coefficient upper bound")
legend("Lower bound","Upper bound")


