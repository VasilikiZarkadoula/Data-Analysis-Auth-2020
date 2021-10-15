% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 5 Excerise 7
% Polynomial regression model

clc;
clear;

data = importdata('resist.txt');
R = data(:,2);
tempC = data(:,3);
tempK = tempC + 273.15;
y = 1./tempK;
x = log(R);

% Scatterplot
figure;
scatter(x,y);
xlabel("ln(R)");
ylabel("1/T");
title('Scatter plot')

% a) find suitable kth degree polynomial regression model

K = 4;  

R2 = zeros(K,1);
adjR2 = zeros(K,1);
for k = 1:K
    p = polyfit(x,y,k);
    yhat = polyval(p,x);
    e = y - yhat;
    
    se = (1/(length(y)-(k+1)))*(sum((y-yhat).^2));
    se = sqrt(se);
    estar = e ./ se;
    
    R2(k) = 1-(sum(e.^2))/(sum((y-mean(y)).^2));
    adjR2(k) =1-((length(y)-1)/(length(y)-(k+1)))*(sum(e.^2))/(sum((y-mean(y)).^2));
    
    figure(k);
    scatter(y,estar);
    hold on
    plot(xlim, [2 2], 'r')
    hold on
    plot(xlim, [-2 -2], 'r')
    title(['Diagnostic plot, polynomial model k-',num2str(k),' degree']);
    annotation('textbox', [0.65, 0.8, 0.1, 0.1], 'String', "R2 = " + R2(k))
    annotation('textbox', [0.65, 0.7, 0.1, 0.1], 'String', "adjR2 = " + adjR2(k))
    hold off
    
end

%--------------------------------------------------------------------------

% b) choose polynomial model and compare it to Steinhart-Hart model

% Steinhart-Hart
X = [ones(length(x),1) x x.^3];
[b, bint,r,rint,stats] = regress(y,X);
yhatSH = X * b;

eSH = y - yhatSH;
seSH = (1/(length(y)-(k+1)))*(sum((y-yhatSH).^2));
seSH = sqrt(seSH);
e_stand_SH = e ./ seSH;
R2_SH = 1-(sum(eSH.^2))/(sum((y-mean(y)).^2));
adjR2_SH =1-((length(y)-1)/(length(y)-(k+1)))*(sum(eSH.^2))/(sum((y-mean(y)).^2));

figure;
scatter(x,yhatSH);
hold on;
plot(x,yhatSH);
title("Data and Steinhart-Hart regression");
xlabel("ln(R)");
ylabel("1/T");

figure;
scatter(y,e_stand_SH);
hold on
plot(xlim, [2 2], 'r')
hold on
plot(xlim, [-2 -2], 'r')
hold off

fprintf('=== Steinhart-Hart model \n \t coefficients: \n');
fprintf('b0 = %1.10f \n',b(1));
fprintf('b1 = %1.10f \n',b(2));
fprintf('b3 = %1.10f \n',b(3));

