% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 4 Excerise 3
% Uncertainty in power dissipated in a circuit of alternating current

clc;
clear;

% check if power has the expected accuracy
% V,I,f are not correlated

meanV = 77.78;
stdV = 0.71;
meanI = 1.21;
stdI = 0.071;
meanf = 0.283;
stdf = 0.017;

M = 1000;

V = zeros(1,M);
I = zeros(1,M);
f = zeros(1,M);
P = zeros(1,M);
for i = 1:M
    V(i) = normrnd(meanV,stdV);
    I(i) = normrnd(meanI,stdI);
    f(i) = normrnd(meanf,stdf);
    P(i) = V(i)*I(i)*cos(f(i));
end

meanP= mean(P);
stdP = std(P);
sigmaP = sqrt((meanI*cos(meanf))^2*stdV^2 + (meanV*cos(meanf))^2*stdI^2 + (meanV*meanI*(-sin(meanf)))^2*stdf^2);
fprintf('Expected STD for P = %2.3f   Observed STD for P = %2.3f \n',sigmaP,stdP);

%--------------------------------------------------------------------------

% check if power has the expected accuracy
% V,f are correlated

pVf = 0.5;
sigmaPnew  = sqrt(sigmaP + 2*meanI*cos(meanf)*meanV*meanI*(-sin(meanf))*stdV*stdf*pVf);

meanAll = [meanI meanV meanf]';
covvf = pVf*stdV*stdf;
sigmaAll = [stdI^2 0 0; 0 stdV^2 covvf; 0 covvf stdf^2];
x = mvnrnd(meanAll,sigmaAll,M); 
i = x(:,1);
v = x(:,2);
f = x(:,3);
p = v.*i.*cos(f);
stdp = std(p);
fprintf('Expected SD for P = %2.3f   Observed SD for P = %2.3f \n',sigmaPnew,stdp);


