function [EV,EDD,time]=Ncut_eigen(W,K)
% Solve the eigensystem by Ncut. The smallest K eigenvalues and their
% corresponding eigenvectors are calculated. 
% 2016-4-8 16:46:42

tic;
D=diag(sum(W));
E=diag(sparse(1./sqrt(diag(D)))); % D^(-1/2)
[EV,ED]=eigs(E*(D-W)*E+10*eps*speye(size(W)),K,'SM'); % add a small regularization
EDD=diag(ED);
[EDD,ix]=sort(EDD,'descend'); % sort the eigenvectors in descending order
EV=EV(:,ix);
EV=E*EV; % y=D^(-1/2)*z
EV=parc_eigenvector(EV);
EV=EV./repmat(sqrt(sum(EV.^2,1)),[size(EV,1),1]); % normalized each column to be unit length
time=toc/3600;