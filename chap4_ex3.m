% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 4 Excerise 3
% Uncertainty in power dissipated from an alternating current circuit

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
% law of propagation of errors
sigmaP = sqrt((meanI*cos(meanf))^2*stdV^2 + (meanV*cos(meanf))^2*stdI^2 + (meanV*meanI*(-sin(meanf)))^2*stdf^2);

M = 1000;

V = normrnd(meanV,stdV,M,1);
I = normrnd(meanI,stdI,M,1);
f = normrnd(meanf,stdf,M,1);
P = V.*I.*cos(f);

meanP = mean(P);
stdP = std(P);
fprintf('Expected STD for P = %2.3f\nObserved STD for P = %2.3f \n',sigmaP,stdP);

%--------------------------------------------------------------------------

% check if power has the expected accuracy
% V,f are correlated
pVf = 0.5;
sigmaPnew  = sqrt(sigmaP + 2*meanI*cos(meanf)*meanV*meanI*(-sin(meanf))*stdV*stdf*pVf);

meanAll = [meanI meanV meanf]';
covVF = pVf*stdV*stdf;
sigmaAll = [stdI^2 0 0; 0 stdV^2 covVF; 0 covVF stdf^2];
x = mvnrnd(meanAll,sigmaAll,M); 

i = x(:,1);
v = x(:,2);
f = x(:,3);

p = v.*i.*cos(f);
pStd = std(p);
fprintf('\nExpected SD for P = %2.3f\nObserved SD for P = %2.3f \n',sigmaPnew,pStd);
