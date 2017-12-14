% unzip the toolbox and data
% 2017-12-14 15:28:23

clear,clc;

%% the NIfTI toolbox
unzip('NIfTI_20140122.zip','NIfTI/'); % unzip
addpath('NIfTI/'); % add path

%% fMRI data
unzip('SLIC_individual_data.zip');
gunzip('*.gz');
delete('*.gz');

%% some useful informations
% number of subjects
sFile=dir('sub*.nii');
nSub=length(sFile);

% number of clusters
sK=[25:25:500]; 
nK=length(sK);

% number of parallel workers
% set it carefully
nPar=36; 

% load subject IDs
sSub=zeros(nSub,1);
for iSub=1:nSub
    filename=sFile(iSub,1).name;
    cSub=str2num(filename(4:8)); 
    sSub(iSub,1)=cSub; 
end

% save the informations for later usage
save('sInfo.mat','sSub','nSub','sK','nK','nPar');

%% move data
load sInfo.mat;
mkdir('data');
for iSub=1:nSub
    cSub=sSub(iSub);
    movefile(sprintf('sub%05d.nii',cSub),sprintf('data/sub%05d.nii',cSub));
end