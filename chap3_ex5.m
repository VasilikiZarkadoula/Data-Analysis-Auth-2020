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
    [~,~,varCI(i,:),~] = vartest(data,var(data));
    [~,~,meanCI(i,:),~] = ttest(data,mean(data));
    [h(i),p(i)] = chi2gof(data);
    if h(i) == 1
        fprintf('The hypothesis that normal distribution fits is rejected\n')
    else
        fprintf('The hypothesis that normal distribution fits is accepted\n')
    end
end
stdCI = sqrt(varCI);
fprintf('\nConfidence interval of standart deviation of waiting time in 1989 is [%0.3f %0.3f]\n',stdCI(1,1),stdCI(1,2));
fprintf('Confidence interval of standart deviation of duration in 1989 is [%0.3f %0.3f]\n',stdCI(2,1),stdCI(2,2));
fprintf('Confidence interval of standart deviation of waiting time in 2006 is [%0.3f %0.3f]\n',stdCI(3,1),stdCI(3,2));

% hypothesis test that std = 10 for waiting time and std = 1 for duration
[h1,~,~,~] = vartest(eruption(:,1),100);
if h1 == 1
    fprintf('\nThe hypothesis that std = 10 for waiting time is rejected\n')
else
    fprintf('The hypothesis that std = 10 for waiting time is accepted\n')
end
[h2,~,~,~] = vartest(eruption(:,2),1);
if h2 == 1
    fprintf('The hypothesis that std = 1 for duration is rejected\n')
else
    fprintf('The hypothesis that std = 1 for duration is accepted\n')
end

% hypothesis test that mean = 75 for waiting time and mean = 2.5 for duration
fprintf('\nConfidence interval of mean of waiting time in 1989 is [%0.3f %0.3f]\n',meanCI(1,1),meanCI(1,2));
fprintf('Confidence interval of mean of duration in 1989 is [%0.3f %0.3f]\n',meanCI(2,1),meanCI(2,2));
fprintf('Confidence interval of mean of waiting time in 2006 is [%0.3f %0.3f]\n',meanCI(3,1),meanCI(3,2));

[h4,~,~,~] = ttest(eruption(:,1),75);
if h4 == 1
    fprintf('\nThe hypothesis that mean = 75 for waiting time is rejected\n')
else
    fprintf('The hypothesis that mean = 75 for waiting time is accepted\n')
end
[h5,~,~,~] = ttest(eruption(:,2),2.5);
if h5 == 1
    fprintf('The hypothesis that mean = 2.5 for duration is rejected\n')
else
    fprintf('The hypothesis that mean = 2.5 for duration is accepted\n')
end

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
    fprintf('\nClaim is true\n')
else
    fprintf('\nClaim is not true\n')
end

