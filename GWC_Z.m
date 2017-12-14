function Z=GWC_Z(S,K)
% update Z when fixing S and alpha
% input: S, graph
%        K, cluster number
% output: Z, eigenvectors
% 2017-5-15 21:19:20

n=size(S,1);

S=(S+S')/2; % to be symmetric
D=diag(S*ones(n,1));
L=D-S; % Laplacian matrix

% It is not necessary to sort the eigenvectors. ?
[EV,ED]=eigs(L+10*eps*eye(size(L)),K,'SM'); % K smallest eigenvalues
EDD=diag(ED);
[EDD,ix]=sort(EDD,'descend'); % sort the eigenvectors in descending order
EV=EV(:,ix);
Z=EV;
