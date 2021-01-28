% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 6 Excerise 6
% 
clc;
clear;
close all;

data = importdata('physical.txt');
y = data(:,1);
X = data(:,2:end);
n = length(y);

% Ordinary Least Square regression
OLSmodel = fitlm(X,y);
bOLS = OLSmodel.Coefficients.Estimate;
yOLS = OLSmodel.Fitted;
R2Array(1) = OLSmodel.Rsquared.Ordinary;
adjR2Array(1) = OLSmodel.Rsquared.Adjusted;

% Stepwise regression
[b,seStep,~,StepwiseModel,stats] = stepwisefit(X,y);
b0 = stats.intercept;
bStepwise = [b0; b(StepwiseModel)];     
yStepwise = [ones(length(X),1) X(:,StepwiseModel)]*bStepwise;
eStepwise = y - yStepwise;
seStepwise = sqrt((1/n-2)*sum(eStepwise.^2));
R2Array(2) = 1-(sum(eStepwise.^2))/(sum((y-mean(y)).^2));
adjR2Array(2) = 1-((n-1)/(n-length(bStepwise)))*(sum(eStepwise.^2))/(sum((y-mean(y)).^2));
clc;

% PCR regression
[PCAloadings,PCAscores] = pca(X,'Economy',false);
bPCR = regress(y-mean(y), PCAscores(:,1:2));
bPCR = PCAloadings(:,1:2)*bPCR;
bPCR = [mean(y) - mean(X)*bPCR; bPCR];
yPCR = [ones(length(X),1) X]*bPCR;
ePCR = y - yPCR;
R2Array(3) = 1-(sum(ePCR.^2))/(sum((y-mean(y)).^2)); 
adjR2Array(3) = 1-((n-1)/(n-length(bPCR)))*(sum(ePCR.^2))/(sum((y-mean(y)).^2));

% PLS regression
[~,~,~,~,bPLS] = plsregress(X,y,1);
yPLS = [ones(length(X),1) X]*bPLS;
ePLS = yPLS -y;
R2Array(4) = 1-(sum(ePLS.^2))/(sum((y-mean(y)).^2)); 
adjR2Array(4) = 1-((n-1)/(n-length(bPLS)))*(sum(ePLS.^2))/(sum((y-mean(y)).^2));

% RR regression
bRR = ridge(y,X,1,0);
yRR = [ones(length(X),1) X]*bRR;
eRR = yRR - y;
R2Array(5) = 1-(sum(eRR.^2))/(sum((y-mean(y)).^2)); 
adjR2Array(5) = 1-((n-1)/(n-length(bRR)))*(sum(eRR.^2))/(sum((y-mean(y)).^2));

% LASSO regression
lambda = 1;
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
