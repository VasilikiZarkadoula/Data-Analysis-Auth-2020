% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 2 Excerise 1
% Generation of discrete uniform data and computation of the occurrence of 
% a discrete value.
% Flipping coin

close all;
clc;
clear;

n = [10 100 500 1000 2500 5000 7500 10000];
N = categorical(n);

% Flipping coin - Uniformly distributed random numbers

numofHeads = zeros(length(n),1);
numofTails = zeros(length(n),1);
tailsRatio = zeros(length(n),1);
for j = 1:length(n)
    heads = 0;
    tails = 0;
    % Flip the coin n times
    for i = 1:n(j)
        x = rand;
        if x < 0.5
            heads = heads + 1;
        else
            tails = tails + 1;
        end
    end
    numofHeads(j) = heads;
    numofTails(j) = tails;
    tailsRatio(j) = numofTails(j)/n(j);
end

figure(1);
bar(N,tailsRatio);
xlabel('Number of iterations (n) of flipping coin');
ylabel('Tails ratio in n iterations')
ylim([0 1])

%--------------------------------------------------------------------------

% Flipping coin - Random numbers from discrete uniform distribution
% 1 for heads, 2 for tails

numofHeads = zeros(length(n),1);
numofTails = zeros(length(n),1);
tailsRatio = zeros(length(n),1);
for j = 1:length(n)
    heads = 0;
    tails = 0;
    % Flip the coin n times
    for i = 1:n(j)
        x = unidrnd(2);
        if x == 1
            heads = heads + 1;
        else
            tails = tails + 1;
        end
    end
    numofHeads(j) = heads;
    numofTails(j) = tails;
    tailsRatio(j) = numofTails(j)/n(j);
end

figure(2);
bar(N,tailsRatio);
xlabel('Number of iterations (n) of flipping coin');
ylabel('Tails ration in n iterations')
ylim([0 1])



