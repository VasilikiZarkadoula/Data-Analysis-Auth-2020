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
yhat = linearModel.Fitted;

e = table2array(linearModel.Residuals(:,1));

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
clc;

% Comparisons
fprintf('Linear vs Stepwise model:\n');
fprintf('\nLinear R2 = %1.10f - Stepwise R2 = %1.10f \n',R2,R2Stepwise);
fprintf('Linear AdjR2 = %1.10f - Stepwise AdjR2 = %1.10f \n',adjR2,adjR2Stepwise);

% Multicollinearity check
r2 = zeros(size(data,2)-1,1);
adjr2 = zeros(size(data,2)-1,1);
for i = 2:size(data,2)
    temp = data;
    Y = temp(:,i);
    temp(:,i) = [];
    X = temp;
    
    Model = fitlm(X,Y);
    B = Model.Coefficients.Estimate;
    Yhat = Model.Fitted;
    e = table2array(Model.Residuals(:,1));
    
    r2(i-1) = Model.Rsquared.Ordinary;
    adjr2(i-1) = Model.Rsquared.Adjusted;
end

fprintf('\nMulticollinearity check:\n\n');
fprintf('  R2        AdjR2\n');
fprintf('%0.3f      %0.3f\n',r2(1),adjr2(1));
fprintf('%0.3f      %0.3f\n',r2(2),adjr2(2));
fprintf('%0.3f      %0.3f\n',r2(3),adjr2(3));
