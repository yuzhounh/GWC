function sub_weight(iSub)
% the individual subject level weight matrix with spatial constraint and a 
% hard threshold
% 2016-4-8 16:00:17

tic;

load sInfo.mat;
load parc_graymatter.mat;

cSub=sSub(iSub);
load(sprintf('data/sub%05d_norm.mat',cSub));

R=img_gray*img_gray'; % correlation
R=2.*(1-R); % correlation to square of (feature) distance
R=R/median(R(:));
R=exp(-R.^2); 

load parc_distance.mat; % A graph by the Gaussian of distance

W=R.*D; % weight
time=toc/3600;
save(sprintf('sub_weight/sub%05d.mat',cSub),'W','time','-v7.3');
fprintf('Time to construct weight matrix: %0.2f hours. \n',time);