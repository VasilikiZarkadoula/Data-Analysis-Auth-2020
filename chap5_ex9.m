% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 5 Excerise 9
% Compare linear regression model with stepwise regression model
% Multicollinearity check

clc;
clear;

data = importdata('hospital.txt');
y = data(:,1);
x = data(:,2:end);

% Linear regression
linearModel = fitlm(x,y);
b = linearModel.Coefficients.Estimate;
yhat = predict(linearModel, x, 'Prediction', 'curve');
l = length(y);
n = length(b);
e = y - yhat;
se = sqrt((1/l-2)*sum(e.^2));
R2 = 1-(sum(e.^2))/(sum((y-mean(y)).^2));
adjR2 = 1-((length(y)-1)/(length(y)-(n+1)))*(sum(e.^2))/(sum((y-mean(y)).^2));

% Stepwise regression
[bS,seStep,~,StepwiseModel,stats] = stepwisefit(x,y);
b0 = stats.intercept;
bStepwise = [b0; bS(StepwiseModel)];     
yhatStepwise = [ones(length(x),1) x(:,StepwiseModel)]*bStepwise;
eStepwise = y - yhatStepwise;
seStepwise = sqrt((1/l-2)*sum(eStepwise.^2));
R2Stepwise = 1-(sum(eStepwise.^2))/(sum((y-mean(y)).^2));
adjR2Stepwise = 1-((length(y)-1)/(length(y)-(n+1)))*(sum(eStepwise.^2))/(sum((y-mean(y)).^2));

% Comparisons
fprintf('=== Linear vs Stepwise model \n \t : \n');
fprintf('\nLinear R2 = %1.10f - Stepwise R2 = %1.10f \n',R2,R2Stepwise);
fprintf('Linear AdjR2 = %1.10f - Stepwise AdjR2 = %1.10f \n',adjR2,adjR2Stepwise);

% Multicollinearity check
r2 = zeros(size(data,2),1);
adjr2 = zeros(size(data,2),1);
for i = 2:size(data,2)
    temp = data;
    Y = temp(:,i);
    temp(:,i) = [];
    X = temp;
    
    Model = fitlm(X,Y);
    B = linearModel.Coefficients.Estimate;
    N = length(B);
    Yhat = predict(Model, X, 'Prediction', 'curve');
    error = Y - Yhat;
    r2(i) = 1-(sum(error.^2))/(sum((Y-mean(Y)).^2));
    adjr2(i) = 1-((length(Y)-1)/(length(Y)-(N+1)))*(sum(error.^2))/(sum((Y-mean(Y)).^2));      
end


