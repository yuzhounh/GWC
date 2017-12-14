function sub_eigen(iSub)
% Apply Ncut on the weight matrix to extract features/eigenvectors. The 
% eigenvectors obtained would be input into clustering algorithms to do 
% parcellation. 
% 2016-4-8 16:01:58 

tic;

load sInfo.mat;
load parc_graymatter.mat;

cSub=sSub(iSub);
load(sprintf('sub_weight/sub%05d.mat',cSub)); % weight matrix

K0=1000; % calculate at most 1000 nontrivial eigenvectors
[EV,EDD]=Ncut_eigen(W,K0); 
nTrivial=sum(EDD<1e-4);  % the number of trivial eigenvalues

time=toc/3600;
save(sprintf('sub_eigen/sub%05d.mat',cSub),'EV','EDD','nTrivial','time');
fprintf('Time to calculate eigenvectors: %0.2f hours. \n\n',time);
