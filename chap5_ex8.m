% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 5 Excerise 8
% Compare linear regression model with stepwise regression model

clc;
clear;

data = importdata('physical.txt');
y = data(:,1);
x = data(:,2:end);

% Linear regression
linearModel = fitlm(x,y);
b = linearModel.Coefficients.Estimate;
yhat = linearModel.Fitted;

e = table2array(linearModel.Residuals(:,1));
eStar = table2array(linearModel.Residuals(:,2)); % or eStar = e./(linearModel.RMSE);

R2 = linearModel.Rsquared.Ordinary;
adjR2 = linearModel.Rsquared.Adjusted;


% Stepwise regression
[bS,~,~,StepwiseModel,stats] = stepwisefit(x,y);
b0 = stats.intercept;
bStepwise = [b0; bS(StepwiseModel)];     
yhatStepwise = [ones(length(x),1) x(:,StepwiseModel)]*bStepwise;
eStepwise = y - yhatStepwise;
seStepwise = sqrt( 1/(length(y)-length(bStepwise))*sum(eStepwise).^2 );
R2Stepwise = 1-(sum(eStepwise.^2))/(sum((y-mean(y)).^2));
adjR2Stepwise = 1-((length(y)-1)/(length(y)-(length(bStepwise)+1)))*(sum(eStepwise.^2))/(sum((y-mean(y)).^2));

% Comparisons
fprintf('Linear vs Stepwise model: \n');
fprintf('\nLinear R2 = %1.10f - Stepwise R2 = %1.10f \n',R2,R2Stepwise);
fprintf('Linear AdjR2 = %1.10f - Stepwise AdjR2 = %1.10f \n',adjR2,adjR2Stepwise);
