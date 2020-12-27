% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 6 Excerise 3
% Principal component analysis (pca)

clc;
clear;

data = importdata('physical.txt');

% a) estimate new dimension

dataCentered = data - mean(data);
[eigenvectors,score,eigenvalues] = pca(dataCentered);
m = mean(eigenvalues);
threshold = 0.7*m;
% scree plot
plot(1:length(eigenvalues),eigenvalues,'ko-');
hold on 
plot( xlim, [threshold threshold] )
title('Scree Plot')
xlabel('Index')
ylabel('eigenvalue')

dim = find(eigenvalues>threshold);
newDimension = max(dim);

%--------------------------------------------------------------------------

% b) plot 2d and 3d PCA components
 
score2d = dataCentered*eigenvectors(:,1:2);
figure(1)
scatter(score2d(:,1),score2d(:,2))
xlabel('PC1')
ylabel('PC2')
title('2d Principal component scores')

score3d = dataCentered*eigenvectors(:,1:3);
figure(2)
scatter3(score3d(:,1),score3d(:,2),score3d(:,3))
xlabel('PC1')
ylabel('PC2')
zlabel('PC3')
title('3d Principal component scores')
