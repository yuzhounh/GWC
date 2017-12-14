function [LG,L,Iter,time]=Ncut_kway(X,nCluster)
% K-way clustering for multigraph. 
% Input:
%     X, the eigenvectors extracted by Ncut
%     nCluster, the desired cluster number
% Output:
%     LG, the group parcellation results
%     L, the individial parcellation results generated simutaneously
%     time, the elapsed time
%     
% See (Yu and Shi, 2003) for the multi-class spectral clustering (MSC) 
% algorithm and (Shen et al., 2013) for the multigraph K-way spectral
% clustering (MKSC) algorithm. 
% 
% 2014-10-14 09:56:30

tic;
X=X(:,end-nCluster+1:end,:); % select only eigenvectors with the K smallest nontrivial eigenvalues
[nVoxel,nCluster,nSub]=size(X);

% normalize Xs so that each row has unit norm
for iSub=1:nSub
    Xs=X(:,:,iSub); % eigen vectors of the iSub-th subject
    Xs=Xs./repmat(sqrt(sum(Xs.^2,2)),[1,nCluster]); 
    X(:,:,iSub)=Xs;
end

% initialize R
R=zeros(nCluster,nCluster,nSub); % rotation matrix
% rng(1);
% RN=randi(nVoxel,[nSub,1]); % a random number in [1:nVoxel] for each subject
RN=ones(nSub,1); % a fixed initialization
for iSub=1:nSub
    Xs=X(:,:,iSub);
    Rs=R(:,:,iSub);
    Rs(:,1)=Xs(RN(iSub),:);
    sigma=zeros(nVoxel,1); % "c" in Yu and Shi, 2003. Replaced by sigma here to avoid misusing.
    for iCluster=2:nCluster
        sigma=sigma+abs(Xs*Rs(:,iCluster-1));
        [~,ix]=min(sigma);
        Rs(:,iCluster)=Xs(ix,:)';
    end
    R(:,:,iSub)=Rs;
end

TV=1; % trace value
DF=1; % the difference between the current trace value and the previous trace value
Iter=0; % iteration number
fprintf('Iteration number, relative error\n');
while DF>1e-3 && Iter<100
    Iter=Iter+1;
    TVP=TV; % previous trace value
    
    % step 1: given R, solve YG
    Z=zeros(nVoxel,nCluster);
    Y=zeros(nVoxel,nCluster,nSub); % individual parcellation result 
    YG=zeros(nVoxel,nCluster); % groupwise parcellation result
    for iSub=1:nSub
        Xs=X(:,:,iSub);
        Rs=R(:,:,iSub);
        Ys=Xs*Rs;
        Z=Z+Ys;
        Y(:,:,iSub)=Ys;
    end
    [~,ix]=max(Z,[],2);
    for i=1:nVoxel
        YG(i,ix(i))=1;
    end
    
    % step 2: given YG, solve R
    S=zeros(nCluster,nCluster,nSub);
    for iSub=1:nSub
        Xs=X(:,:,iSub);
        [Us,Ss,Vs]=svd(YG'*Xs);
        Rs=Vs*Us';
        R(:,:,iSub)=Rs;
        S(:,:,iSub)=Ss;
    end
    
    % check for convergence
    TV=0;
    for iSub=1:nSub
        Ss=S(:,:,iSub);
        TV=TV+trace(Ss);
    end
    % DF=abs(TV-TVP);
    DF=abs(TV-TVP)/abs(TV);
    fprintf('MSC: %02d, %0.4f \n',Iter,DF);
end

% groupwise parcellation result
[~,LG]=max(YG,[],2); % vector form of the label
fprintf('Actual number of clusters in group level: %d. \n', length(unique(LG)));

% individual parcellation result 
L=zeros(size(Y,1),nSub);
for iSub=1:nSub
    [~,tmp]=max(Y(:,:,iSub),[],2);
    L(:,iSub)=tmp;
end

time=toc/3600;
fprintf('Time to run K-way clustering: %0.2f hours. \n\n',time);
