% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 5 Excerise 6
% Regression models

clc;
clear;

data = [1 2 98.2;2 3 91.7;3 8 81.3;4 16 64.0;
5 32 36.4;6 48 32.6;7 64 17.1;8 80 11.3];

n = length(data);
X = data(:,2);
Y = data(:,3);

% a) find suitable regression model 

figure(100)
scatter(X,Y)
hold on

% 1. linear regression model 
Xones = [ones(n,1) X];
[b1, ~,~,~,~] = regress(Y,Xones);
Yhat = Xones* b1;

meanY = mean(Y);
e = Y-Yhat;
se2 = (1/(n-1))*(sum((Y-Yhat).^2));
se = sqrt(se2);
estar = e ./ se;
R2 = 1-(sum(e.^2))/(sum((Y-meanY).^2));
adjR2 =1-((n-1)/(n-2))*(sum(e.^2))/(sum((Y-meanY).^2));

h = lsline;           
h.Color = 'r';
annotation('textbox', [0.65, 0.8, 0.1, 0.1], 'String', "R2 = " + R2)
annotation('textbox', [0.65, 0.7, 0.1, 0.1], 'String', "adjR2 = " + adjR2)
title('Linear regression line') 
hold off

figure(101);
scatter(Y,estar)
hold on;
plot(xlim,[2 2],'r--');
hold on;
plot(xlim,[-2 -2],'r--');
title('Diagnostic plot')
hold off

% 2. Intrinsically linear regression model 
% i) Power
power = @(b,x)( b(1)*x.^(b(2)) );
% ii) Logarithmic
logarithmic = @(b,x)( b(1)+b(2)*log(x));
% iii) Inverse
inverse = @(b,x)( b(1) + b(2)./x);
% iv) Exponential
exponential = @(b,x)( b(1)*exp(b(2)*x) );

functions = {power ; logarithmic; inverse; exponential};
functionNames = ["Power" ; "Logarithmic"; "Inverse"; "exponential"];

mse = zeros(length(functions),1);
r2 = zeros(length(functions),1);
adjr2 = zeros(length(functions),1);
for i = 1:length(functions)
    
    beta0 = [10 ; -0.1];
    model = fitnlm(X,Y,functions{i},beta0);
    
    mse(i) = model.MSE;
    beta = model.Coefficients.Estimate;
    pred = functions{i}(beta,X);
    E = Y-pred;
    r2(i) = 1-(sum(E.^2))/(sum((Y-meanY).^2));
    adjr2(i) =1-((n-1)/(n-2))*(sum(E.^2))/(sum((Y-meanY).^2));
    
    % Plot data and regression
    figure(i)
    scatter(X,Y)
    hold on;
    plot(X,pred)
    annotation('textbox', [0.65, 0.8, 0.1, 0.1], 'String', "R2 = " + r2(i))
    annotation('textbox', [0.65, 0.7, 0.1, 0.1], 'String', "adjR2 = " + adjr2(i))
    title(strcat(functionNames(i)," regression"));
    
    %----------------------------------------------------------------------
    
    % b) predict y for x0 = 25
    
    x0 = 25;
    prediction = functions{i}(beta,x0);
    hold on;
    plot(x0,prediction,'x','MarkerEdgeColor','k','MarkerSize',5);

    % Diagnostic plot of standardised error
    ei_standard = (Y - pred)/sqrt(mse(i));
    figure(i*10)
    scatter(Y,ei_standard);
    hold on;
    plot(xlim,[2 2],'r--');
    hold on;
    plot(xlim,[-2 -2],'r--');
    title(strcat(functionNames(i)," diagnostic plot"));
    hold off
end