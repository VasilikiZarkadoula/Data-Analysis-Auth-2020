% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 4 Excerise 2
% Uncertainty in measuring rectangular areas

clc;
clear;

%a) uncertainty of surface

sX1 = 5; % uncertainty of length estimation
sX2 = 5; % uncertainty of width estimation

x1 = 500; % length of a surface 
x2 = 300; % width of a surface 

sy = sqrt(x2^2*sX1^2 + x1^2*sX2^2);

%--------------------------------------------------------------------------

%b) plot
x1grid = (1:50:10001)';
x2grid = (1:50:10001)';
n = length(x1grid);
ygrid = NaN*ones(n);
for i=1:n
    for j=1:n
        ygrid(j,i) = sqrt(x2grid(j)^2*sX1^2 + x1grid(i)^2*sX2^2);
    end
end
figure;
surf(x1grid,x2grid,ygrid)
