% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 6 Excerise 3
% Principal component analysis (pca)

clc;
clear;

data = importdata('physical.txt');
data = data(:,2:end);

% a) estimate new dimension

dataCentered = data - mean(data);
[~,scores,eigenvalues] = pca(dataCentered);

m = mean(eigenvalues);
threshold = 0.5*m;
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
 
figure;
scatter(scores(:,1),scores(:,2))
xlabel('PC1')
ylabel('PC2')
title('2d Principal component scores')

figure;
scatter3(scores(:,1),scores(:,2),scores(:,3))
xlabel('PC1')
ylabel('PC2')
zlabel('PC3')
title('3d Principal component scores')
