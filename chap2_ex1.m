% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 2 Excerise 1
% Generation of discrete uniform data and computation of the occurrence of a discrete value.
% Flipping coin

clc;
clear;

n = [10 100 1000 10000];
N = categorical({'10','100','1000','10000'});
N = reordercats(N,{'10','100','1000','10000'});

% Flipping coin - Uniformly distributed random numbers
heads = 0;
tails = 0;
numofHeads = zeros(length(n),1);
numofTails = zeros(length(n),1);
tailsRatio = zeros(length(n),1);
for j = 1:length(n)
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
ylabel('Tails ration in n iterations')
ylim([0 1])

% Flipping coin - Random numbers from discrete uniform distribution
% 1 for heads, 2 for tails
heads = 0;
tails = 0;
numofHeads = zeros(length(n),1);
numofTails = zeros(length(n),1);
tailsRatio = zeros(length(n),1);
for j = 1:length(n)
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



