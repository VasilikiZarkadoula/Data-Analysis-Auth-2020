% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 6 Excerise 1
% Principal component analysis (pca)

clc;
clear;

mu = [0 0];
sigma = [1 0; 0 4];
w = [0.2 0.8; 0.4 0.5; 0.7 0.3];
n = 1000;

x2d = mvnrnd(mu,sigma,n);
x2dCentered = x2d - mean(x2d);

x3d = x2d*w';
x3dCentered = x3d - mean(x3d);

% a) eigenvalues, eigenvectors and pca scores

covX = cov(x3dCentered);
[eigenvectors,eigenvalues] = eig(covX);
eigenvalues = diag(eigenvalues);
[eigenvalues,ind] = sort(eigenvalues,'descend');
eigenvectors = eigenvectors(:, ind);

score3d = x3dCentered*eigenvectors;
[~,scores,~] = pca(x3dCentered);

figure(1)
scatter3(score3d(:,1),score3d(:,2),score3d(:,3))
xlabel('PC1')
ylabel('PC2')
zlabel('PC3')
title('Principal component scores')

%--------------------------------------------------------------------------

% b) scree plot

figure(2)
plot(1:length(eigenvalues),eigenvalues,'ko-');
title('Scree Plot')
xlabel('Index')
ylabel('eigenvalue')

%--------------------------------------------------------------------------

% c) Initial data in 2d plot and 2d PCA components
 
figure(3)
scatter(x2dCentered(:,1),x2dCentered(:,2))
xlabel('x1')
ylabel('x2')
title('2D Scatteplot')

figure(4)
score2d = x3dCentered*eigenvectors(:,1:2);
scatter(score2d(:,1),score2d(:,2))
xlabel('PC1')
ylabel('PC2')
title('Principal component scores')
