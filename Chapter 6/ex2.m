% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 6 Excerise 2
% Principal component analysis (pca)

clc;
clear;
close all;

data = importdata('yeast.txt');
data = data';

% a) estimate new dimension

dataCentered = data - mean(data); % or dataCentered = normalize(data,'center');
[~,scores,eigenvalues] = pca(dataCentered);

m = mean(eigenvalues);
threshold = 0.7*m;
dim = find(eigenvalues>threshold);
newDimension = max(dim);

% scree plot
figure;
plot(1:length(eigenvalues),eigenvalues,'ko-');
hold on 
plot( xlim, [threshold threshold] )
title('Scree Plot')
xlabel('Index')
ylabel('eigenvalue')
hold off


%--------------------------------------------------------------------------

% b) plot 2d and 3d PCA components
 
% score2d = dataCentered*eigenvectors(:,1:2);
figure;
scatter(scores(:,1),scores(:,2))
xlabel('PC1')
ylabel('PC2')
title('2d Principal component scores')

% score3d = dataCentered*eigenvectors(:,1:3);
figure;
scatter3(scores(:,1),scores(:,2),scores(:,3))
xlabel('PC1')
ylabel('PC2')
zlabel('PC3')
title('3d Principal component scores')
