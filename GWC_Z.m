function Z=GWC_Z(S,K)
% update Z when fixing S and alpha
% input: S, graph
%        K, cluster number
% output: Z, eigenvectors
% 2017-5-15 21:19:20

S=(S+S')/2; % to be symmetric
n=size(S,1);
D=diag(S*ones(n,1));
L=D-S; % Laplacian matrix

[EV,ED]=eigs(L+10*eps*eye(size(L)),K,'SM'); % K smallest eigenvalues
EDD=diag(ED);
[~,ix]=sort(EDD,'descend'); % sort the eigenvalues in descending order
EV=EV(:,ix); % sort the eigenvectors accordingly
Z=EV;
