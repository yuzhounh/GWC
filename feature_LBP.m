function feature_LBP(iSub)
% calculate 3D LBP according to (Montagne et al., 2013). 
% 2017-3-14 22:47:22

load sInfo.mat;

load parc_graymatter.mat;
nVoxel=num_gray;

% create a searchlight
r=1;
shape='sphere';
[riSL,nvSL]=parc_searchlight(r,shape);

cSub=sSub(iSub);
load(sprintf('data/sub%05d.mat',cSub));
nV=size(img_gray,2); % volumes

tic;
LBP=size(nVoxel,nV);
for iVoxel=1:nVoxel
    % set a specific voxel in the graymatter as the center of the
    % searchlight
    ix_center=ind_gray(iVoxel);
    
    % the indices of the voxels in the searchlight
    [a,b,c]=ind2sub(siz,ix_center);
    tmp=repmat([a,b,c],nvSL,1)+riSL;
    ix_voxels=sub2ind(siz,tmp(:,1),tmp(:,2),tmp(:,3));
    
    % the time series of the voxels in the searchlight
    temp=zeros(nvSL,size(img_gray,2));
    [a,b]=ismember(ix_voxels,ind_gray);
    temp(a,:)=img_gray(b(a),:);
    
    % calculate LBP for each time point separately
    for iV=1:nV
        tmp=temp(:,iV); % a searclight
        
        % compare between the surrounding voxels and the center voxel
        tmp=tmp([1:3,5:7])-tmp(4);
        tmp=double(tmp>=0);
        
        % map the six binary code to LBP(3D,6,1) code
        % ten potential classes
        tmp=feature_LBP_map(tmp);
        
        % save the LBP results
        LBP(iVoxel,iV)=tmp;
    end
    perct(toc,iVoxel,nVoxel,100);
end

save(sprintf('feature_LBP/sub%05d.mat',cSub),'LBP');
