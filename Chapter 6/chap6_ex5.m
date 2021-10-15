% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 6 Excerise 5
% Multiple linear regression models
clc;
clear;
close all;

p = 5;
n = 100;          % random choice
mu = [3 1 5 2 9]; % random choice

X = zeros(n,p);
for i = 1:p
    X(:,i) = exprnd(mu(i),n,1);
end

% random vector (p*1) consisting only from two non-negative elements
b = [0;2;0;-3;0];
% noise
e = normrnd(0,5,n,1);
% response vector
y = X*b+e;

% a)Estimate the multi-linear regression model using the following methods:
% OLS - PCR - PLS - RR - LASSO 

% OLS regression
OLSmodel = fitlm(X,y);
bOLS = OLSmodel.Coefficients.Estimate;
yOLS = OLSmodel.Fitted;
R2Array(1) = OLSmodel.Rsquared.Ordinary;
adjR2Array(1) = OLSmodel.Rsquared.Adjusted;

% PCR regression
[PCAloadings,PCAscores] = pca(X,'Economy',false);
bPCR = regress(y-mean(y), PCAscores(:,1:2));
bPCR = PCAloadings(:,1:2)*bPCR;
bPCR = [mean(y) - mean(X)*bPCR; bPCR];
yPCR = [ones(length(X),1) X]*bPCR;
ePCR = yPCR - y;
R2Array(2) = 1-(sum(e.^2))/(sum((y-mean(y)).^2)); 
adjR2Array(2) = 1-((n-1)/(n-length(bPCR)))*(sum(ePCR.^2))/(sum((y-mean(y)).^2));

% PLS regression
[~,~,~,~,bPLS] = plsregress(X,y,1);
yPLS = [ones(length(X),1) X]*bPLS;
ePLS = yPLS -y;
R2Array(3) = 1-(sum(ePLS.^2))/(sum((y-mean(y)).^2)); 
adjR2Array(3) = 1-((n-1)/(n-length(bPLS)))*(sum(ePLS.^2))/(sum((y-mean(y)).^2));

% RR regression
bRR = ridge(y,X,1,0);
yRR = [ones(length(X),1) X]*bRR;
eRR = yRR - y;
R2Array(4) = 1-(sum(eRR.^2))/(sum((y-mean(y)).^2)); 
adjR2Array(4) = 1-((n-1)/(n-length(bRR)))*(sum(eRR.^2))/(sum((y-mean(y)).^2));

% LASSO regression
lambda = 1e-03;
bLASSO = lasso(X,y,'Lambda',lambda);
yLASSO = X*bLASSO;
eLASSO = yLASSO - y;
R2Array(5) = 1-(sum(eLASSO.^2))/(sum((y-mean(y)).^2)); 
adjR2Array(5) = 1-((n-1)/(n-length(bLASSO)))*(sum(eLASSO.^2))/(sum((y-mean(y)).^2));


% b)for each method -> scatter and diagnostic plot of standardised error

modelList = {'OLS','PCR','PLS','RIDGE','LASSO'};
yhat = [yOLS yPCR yPLS yRR yLASSO];
for i = 1:length(modelList)
    myPlots(y,yhat(:,i),modelList(i),R2Array(i),adjR2Array(i));
end

% Table of Results
b = [0; b];
bLASSO = [0; bLASSO];
bAll = [b, bOLS, bPCR, bPLS, bRR, bLASSO];
muCell = arrayfun(@num2str, mu, 'UniformOutput', 0);
rowNames = {'Intercept' muCell{:}};

table = array2table(bAll,'RowNames',rowNames,'VariableNames',{'Starting_b','OLS','PCR','PLS','Ridge','LASSO'});
disp(table);


