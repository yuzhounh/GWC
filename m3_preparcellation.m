% pre-parcellation
% 2016-4-8 10:34:45

clear,clc;

%% load fMRI data
load sInfo.mat;
parc_parpool(nPar);
parfor iSub=1:nSub
    parc_load(iSub);
end

%% generate supervoxels by SLIC
mkdir('SLIC_supervoxel');
parc_parpool(nPar);
parfor iSub=1:nSub
    SLIC_supervoxel(iSub);
end

%% features
mkdir('feature_LBP');
mkdir('feature_0');
mkdir('feature_1');
mkdir('feature_2');
mkdir('feature_3');
parc_parpool(nPar);
parfor iSub=1:nSub
    feature_LBP(iSub);
    feature_0(iSub);
    feature_1(iSub);
    feature_2(iSub);
    feature_3(iSub);
end

%% graphs
mkdir('graph');
parc_parpool(nPar);
parfor iSub=1:nSub
    graph_sub(iSub);
end