% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 5 Excerise 4
% Linear regression model , confidence intervals

clc;
clear;

lightair = importdata('lightair.dat');
x = lightair(:,1);
y = lightair(:,2);

% a) scatter plot and Correlation coefficient

r = corrcoef(x,y); 
r = r(1,2);
figure(1)
scatter(x,y);   
annotation('textbox', [0.75, 0.8, 0.1, 0.1], 'String', "r = " + r)

%--------------------------------------------------------------------------

% b) linear regression model (Least Square Method), 95% CI of regression
% coefficients

linearModel = fitlm(x,y); 
b = linearModel.Coefficients.Estimate;
ci = coefCI(linearModel);          
fprintf('bo = %2.3f  -  CI of bo = [%2.3f %2.3f] \n',b(1),ci(1,:));
fprintf('b1 = %2.3f  -  CI of b1 = [%2.3f %2.3f] \n',b(2),ci(2,:));

%--------------------------------------------------------------------------

% c) scatter plot, linear regression line, CIs for mean y and an 
% observation of y, prediction for x0 = 1.29 

[yhat1,ypredCI] = predict(linearModel, x, 'Prediction', 'curve'); 
[yhat2,yobservCI] = predict(linearModel, x, 'Prediction', 'observation');

figure(2)
plot(x,y,'o',x,yhat2,'x')
legend('Data','Predictions')

figure(3)
scatter(x,y);
h = lsline;              
h.Color = 'r';
hold on;
plot(x,ypredCI,'--')
hold on;
plot(x,yobservCI,'-.')

x0 = 1.29;
[yhat,yhatCI] = predict(linearModel, x0, 'Prediction', 'curve');
[~,yobserVCI] = predict(linearModel, x0, 'Prediction', 'observation');
hold on;
plot(x0 , yhat,'x','MarkerSize',7,'MarkerEdgeColor','black');
hold on;
plot(x0, yhatCI,'*','MarkerSize',4,'MarkerEdgeColor','magenta');
hold on;
plot(x0, yobserVCI,'s','MarkerSize',7,'MarkerEdgeColor','red');
hold off

%--------------------------------------------------------------------------

% Real regression
figure(4)
Xones = [ones(length(x),1) x];
breal = zeros(2,1);
breal(1) = 299792.458;
breal(2) = -299792.458*0.00029/1.29;
realRegression = Xones*breal - 299000;
plot(x,realRegression,'LineWidth',2,'LineStyle','-','Color','r')

if breal(1)>ci(1,1) && breal(1)<ci(1,2)
    fprintf('Real bo accepted\n');
else
    fprintf('Real bo not accepted\n');
end

if breal(2)>ci(2,1) && breal(2)<ci(2,2)
    fprintf('Real b1 accepted\n');
else
    fprintf('Real b1 not accepted\n');
end

counter = 0;
M = length(realRegression);
for i = 1:M
    if realRegression(i)>ypredCI(i,1) && realRegression(i)<ypredCI(i,2)
        counter = counter +1;
    end
end

fprintf('Real y values are inside the confidence intervals: %0.2f%%',(counter/M)*100)


