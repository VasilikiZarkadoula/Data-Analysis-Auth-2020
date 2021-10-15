% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 2 Excerise 3
% Check that Var[x+y]=Var[x]+Var[y] does not hold when X,Y are not independent

close all;
clc;
clear;

n = 10000;
mu = [0 0];
sigma1 = 1;
sigma2 = 1;
p = 0.5;    % random correlation coefficient

sigma12 = p*sigma1*sigma2;
covMatrix = [sigma1 sigma12; ...
             sigma12 sigma2];

r = mvnrnd(mu,covMatrix,n);     % Multivariate normal random numbers
X = r(:,1);
Y = r(:,2);

varX = var(X);
varY = var(Y);
varXY = var(X+Y);
sumVar = varX + varY;

fprintf('Var[X+Y] =% 3.3f | Var[X] + Var[Y] = %3.3f \n',varXY,sumVar);
if sumVar ~= varXY
    fprintf('Var[x+y] is not equal to Var[x] + Var[y]\n');
else
    fprintf('Var[x+y] is equal to Var[x] + Var[y]\n');
end
