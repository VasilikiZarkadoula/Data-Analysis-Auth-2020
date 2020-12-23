% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 2 Excerise 3
% Check that Var[x+y]=Var[x]+Var[y] does not hold when X,Y are correlated

clc;
clear;

n = 10000;
mu = [0 0];
sigmaX = 1;
sigmaY = 1;
p = 0.8; % random correlation coefficient

sigmaXY = p*sigmaX*sigmaY;
Cov = [sigmaX sigmaXY; sigmaXY sigmaY];

r = mvnrnd(mu,Cov,n); % Multivariate Normal Distribution

varX = var(r(:,1));
varY = var(r(:,2));
varXY = var(r(:,1) + r(:,2));
sumVar = varX+varY;

fprintf('Var[X+Y] =% 3.3f | Var[X] + Var[Y] = %3.3f \n',varXY,sumVar);
if sumVar ~= varXY
    fprintf('Var[x+y] not equal to Var[x]+Var[y]\n');
end
