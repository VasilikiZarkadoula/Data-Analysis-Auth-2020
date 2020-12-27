% Vasia Zarkadoula
% Data Analysis 2020
% Chapter 6 Excerise 3
% Independent component analysis (ica)

clc;
clear;

chirp = load('chirp.mat');
gong = load('gong.mat');
n = 1000;
s1 = chirp.y;
s1 = s1(1:n);
s2 = gong.y;
s2 = s2(1:n);
fs = chirp.Fs;
dt = 1/fs;
t = 0:dt:((n-1)*dt);

% a)

% plot the independant source signals s1, s2
figure(1)
subplot(2,2,1);
plot(t,s1);
xlabel('t [sec]')
ylabel('s1(t)')
title('Source signal 1 : chirp')
subplot(2,2,2);
plot(t,s2);
xlabel('t [sec]')
ylabel('s2(t)')
title('Source signal 2 : gong')
subplot(2,2,[3,4]);
scatter(s1,s2);
xlabel('s1(t)')
ylabel('s2(t)')
title('Scatter diagram source 2D')

% mixing transformation, random 2X2 mixing matrix 
A = [-0.1 0.3; -2.5 -0.2];  
S = [s1 s2];
X = S*A;
x1 = X(:,1);
x2 = X(:,2);

% plot the mixed signals 
figure(2)
subplot(2,2,1);
plot(t,x1);
xlabel('t [sec]')
ylabel('x1(t)')
title('Mixed signal 1')
subplot(2,2,2);
plot(t,x2);
xlabel('t [sec]')
ylabel('x2(t)')
title('Mixed signal 2')
subplot(2,2,[3,4]);
scatter(x1,x2);
xlabel('x1(t)')
ylabel('x2(t)')
title('Scatter diagram source 2D')

% unmix the signals using ICA without prewhitening
% compare the reconstructed source signals with the originals
IcaModel = rica(X,2);
Snew = transform(IcaModel,X);
s1new = Snew(:,1);
s2new = Snew(:,2);

% plot the reconstructed signals 
figure(3)
subplot(2,2,1);
plot(t,s1new);
xlabel('t [sec]')
ylabel('s1(t)')
title('ICA reconstructed s1')
subplot(2,2,2);
plot(t,s2new);
xlabel('t [sec]')
ylabel('s2(t)')
title('ICA reconstructed s2')
subplot(2,2,[3,4]);
scatter(s1new,s2new);
xlabel('s1(t)')
ylabel('s2(t)')
title('Scatter diagram source 2D')

% unmix the signals using ICA with prewhitening
% compare the reconstructed source signals with the originals
mixed = prewhiten(X);
IcaModelNew = rica(mixed,2);
unmixedS = transform(IcaModelNew,mixed);
unmixedS1 = unmixedS(:,1);
unmixedS2 = unmixedS(:,2);

% plot the reconstructed signals 
figure(4)
subplot(2,2,1);
plot(t,unmixedS1);
xlabel('t [sec]')
ylabel('s1(t)')
title('ICA reconstructed s1 (prewhitening)')
subplot(2,2,2);
plot(t,unmixedS2);
xlabel('t [sec]')
ylabel('s2(t)')
title('ICA reconstructed s2 (prewhitening)')
subplot(2,2,[3,4]);
scatter(unmixedS1,unmixedS2);
xlabel('s1(t)')
ylabel('s2(t)')
title('Scatter diagram source 2D (prewhitening)')

%--------------------------------------------------------------------------

% b) repeat (a) but choose random 2X3 mixing matrix 

% mixing transformation
A = [-0.1 0.3 -0.2; -2.5 -0.2 -0.3];  
S = [s1 s2];
X = S*A;
x1 = X(:,1);
x2 = X(:,2);
x3 = X(:,3);

% plot the mixed signals 
figure(5)
subplot(2,2,1);
plot(t,x1);
xlabel('t [sec]')
ylabel('x1(t)')
title('Mixed signal 1')
subplot(2,2,2);
plot(t,x2);
xlabel('t [sec]')
ylabel('x2(t)')
title('Mixed signal 2')
subplot(2,2,[3 4]);
plot(t,x3);
xlabel('t [sec]')
ylabel('x3(t)')
title('Mixed signal 3')

% unmix the signals using ICA without prewhitening
% compare the reconstructed source signals with the originals
IcaModel = rica(X,2);
Snew = transform(IcaModel,X);
s1new = Snew(:,1);
s2new = Snew(:,2);

% plot the reconstructed signals 
figure(6)
subplot(2,1,1);
plot(t,s1new);
xlabel('t [sec]')
ylabel('s1(t)')
title('ICA reconstructed s1')
subplot(2,1,2); 
plot(t,s2new);
xlabel('t [sec]')
ylabel('s2(t)')
title('ICA reconstructed s2')

% unmix the signals using ICA with prewhitening
% compare the reconstructed source signals with the originals
mixed = prewhiten(X);
IcaModelNew = rica(mixed,2);
unmixedS = transform(IcaModelNew,mixed);
unmixedS1 = unmixedS(:,1);
unmixedS2 = unmixedS(:,2);

% plot the reconstructed signals 
figure(7)
subplot(2,1,1);
plot(t,unmixedS1);
xlabel('t [sec]')
ylabel('s1(t)')
title('ICA reconstructed s1 (prewhitening)')
subplot(2,1,2); 
plot(t,unmixedS2);
xlabel('t [sec]')
ylabel('s2(t)')
title('ICA reconstructed s2 (prewhitening)')

function Z = prewhiten(X)
% X = N-by-P matrix for N observations and P predictors
% Z = N-by-P prewhitened matrix

    % 1. Size of X.
    [N,P] = size(X);
    assert(N >= P);

    % 2. SVD of covariance of X. We could also use svd(X) to proceed but N
    % can be large and so we sacrifice some accuracy for speed.
    [U,Sig] = svd(cov(X));
    Sig     = diag(Sig);
    Sig     = Sig(:)';

    % 3. Figure out which values of Sig are non-zero.
    tol = eps(class(X));
    idx = (Sig > max(Sig)*tol);
    assert(~all(idx == 0));

    % 4. Get the non-zero elements of Sig and corresponding columns of U.
    Sig = Sig(idx);
    U   = U(:,idx);

    % 5. Compute prewhitened data.
    mu = mean(X,1);
    Z = bsxfun(@minus,X,mu);
    Z = bsxfun(@times,Z*U,1./sqrt(Sig));
end
