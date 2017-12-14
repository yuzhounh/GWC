function [S,Z,alpha,beta,iter,time]=GWC(iSub,iK,lambda,gamma,nNonzero)
% the GWC algorithm
% 2017-5-24 15:19:07

tic;

% tuning parameters
if nargin==2
    lambda=1e-1;
    gamma=1;
    nNonzero=9;
end

load sInfo.mat;
cSub=sSub(iSub);
cK=sK(iK);

% graphs
load(sprintf('graph/sub%05d.mat',cSub));
n=size(graph_features,1); % number of supervoxels
t=size(graph_features,3); % number of classes of features

% initialize alpha
alpha=ones(3,1)/3;

% initialize S
G=graph_spatial + lambda * graph_weighted(graph_features,alpha);
V=-G/2;
S=GWC_S(V,nNonzero); % problem (13) & (14) without c_i
S=(S+S')/2; % to be symmetric

% Alternative iteration
rel=1;
iter=0;
fprintf('Iteration number, relative error\n');
while rel>1e-3 && iter<100
    S0=S; % results in the previous iteration
    
    % update Z by fixing S and alpha
    % problem (7) & (9)
    Z=GWC_Z(S,cK);
    
    % update S by fixing alpha and Z
    % problem (10)-(13)
    % nNonzero=300; % the number of nonzero elements in each column of S
    graph_eigenvector=graph_fea(Z);
    mu=1e4; % a large enough value, fixed
    G=graph_spatial + lambda * graph_weighted(graph_features,alpha) + mu * graph_eigenvector;
    V=-G/2;
    [S,betas]=GWC_S(V,nNonzero);
    S=(S+S')/2; % to be symmetric
    
    % update alpha by fixing Z and S
    % problem (14)-(16)
    graph_features_vector=reshape(graph_features,[n*n,t]);
    S_vector=reshape(S,[n*n,1]);
    beta=mean(betas);
    v=-graph_features_vector'*S_vector*lambda/(beta*gamma*2);
    alpha=GWC_alpha(v);
    
    % check convergence
    rel=norm(S(:)-S0(:))/norm(S(:)); % relative error
    iter=iter+1;
    fprintf('GWC: %02d, %0.4f \n',iter,rel);
end
fprintf('\n');
time=toc/3600;
