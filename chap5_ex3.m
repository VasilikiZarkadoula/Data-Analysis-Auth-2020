% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 5 Excerise 3
% Randomization check , student t statistic check

clc;
clear;

temp = importdata('tempThes59_97.txt');
rain = importdata('rainThes59_97.txt');

m = size(temp,2);
n = size(temp,1);
L = 100;

paramHypothesisTesting = zeros(m,1);
permHypothesisTesting = zeros(m,1);
t = zeros(L,1);
for i = 1:m
    
    % parametric
    [r,p] = corrcoef(temp(:,i),rain(:,i));
    if( p(1,2) < 0.05 )
        paramHypothesisTesting(i) = 1;
    end
    
    % Permutation
    t0 = r(1,2)*sqrt((n-2)/(1-r(1,2)^2));
    for j = 1:L
        % Caclulate samples permutation
        tempPerm = temp(:,i);
        tempPerm = tempPerm(randperm(n));
        % Calculate t
        r = corrcoef(tempPerm,rain(:,i));
        t(j) = r(1,2)*sqrt( (n-2)/(1-r(1,2)^2) );
    end
    t = sort(t);
    
    % Calculate CI
    alpha = 5;
    percentiles = [alpha/2 (100-alpha)/2];
    CI = prctile(t,percentiles);
    
    if( t0 < CI(1) || t0 > CI(2) )
        permHypothesisTesting(i) = 1;
    end
end
fprintf('Hypothesis rejected (parametric method) : %0.2f%%\n',(sum(paramHypothesisTesting)/m)*100)
fprintf('Hypothesis rejected (randomaziation method): %0.2f%%\n',(sum(permHypothesisTesting)/m)*100)



