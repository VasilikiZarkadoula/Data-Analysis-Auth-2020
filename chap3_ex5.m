% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 3 Excerise 5
% Data from eruption of geyser, waiting time and duration of eruption
% Estimation and hypothesis testing on mean, variance and hypothesis
% testing for goodness of fit to normal distribution.

clc;
clear;

eruption = importdata("eruption.dat");

% compute 95% CI of standard deviation and mean of eruption
% testing for goodness of fit
varCI = zeros(3,2);
meanCI = zeros(3,2);
h = zeros(3,1);
p = zeros(3,1);
for i = 1:3
    data = eruption(:,i);
    [~,~,varCI(i,:),~] = vartest(data,100);
    [~,~,meanCI(i,:),~] = ttest(data,0);
    [~,p(i)] = chi2gof(data);
end
stdCI = sqrt(varCI);

% hypothesis test that std=10 for waiting time and std=1 for duration
[h1,~,~,~] = vartest(eruption(:,1),100);
[h2,~,~,~] = vartest(eruption(:,2),1);

% hypothesis test that mean=75 for waiting time and mean=2.5 for duration
[h4,~,~,~] = ttest(eruption(:,1),75);
[h5,~,~,~] = ttest(eruption(:,2),2.5);

% check if true: ”With an error of 10 minutes, Old Faithful will erupt 65 
% minutes after an eruption lasting less than 2.5 minutes or 91 minutes 
% after an eruption lasting more than 2.5 minutes.”
correctMatrix = [true ; true];
for i = 1:length(eruption)
    if( eruption(i,2) < 2.5 )
        if( eruption(i,1) < 55 || eruption(i,1) > 75 )
            correctMatrix(1) = false;
        end
    else
        if( eruption(i,1) < 81 || eruption(i,1) > 101 )
            correctMatrix(2) = false;
        end
    end
end

if correctMatrix == 1
    fprintf('Claim is true\n')
else
    fprintf('Claim is not true\n')
end

