function parc_eval(method)
% evaluation a parcellation method
% 2017-6-12 13:59:41

mkdir(sprintf('%s_num',method));
mkdir(sprintf('%s_sdi',method));
mkdir(sprintf('%s_hom',method));
mkdir(sprintf('%s_dic',method));

load sInfo.mat;

%% number, spatial discontiguity index, homogeneity
count=0;
for iSub=1:nSub
    for iK=1:nK
        count=count+1;
        stat(count,:)=[iSub,iK];
    end
end
save('stat.mat','stat');
n=size(stat,1);
fprintf('There are %d tasks.\n',n);
parc_parpool(nPar);
parfor i=1:n
    eval_num(method,i);
    eval_sdi(method,i);
    eval_hom(method,i);
end

%% Dice 
% all subject pairs
count=0;
for iSub1=1:nSub
    for iSub2=1:nSub
        if iSub2>iSub1
            count=count+1;
            cSub1=sSub(iSub1);
            cSub2=sSub(iSub2);
            SP(count,:)=[cSub1,cSub2];
        end
    end
end
n=size(SP,1);

% randomly choose m pairs for each cK
m=3;
stat_dice=[];
for iK=1:nK
    rng(iK);
    cK=sK(iK);
    tmp=randperm(n);
    tmp=tmp(1:m);
    stat_dice=[stat_dice;[SP(tmp,:),repmat([cK,iK],[m,1]),[1:m]']];
end
save('stat_dice.mat','stat_dice');

n=size(stat_dice,1);
fprintf('There are %d tasks.\n',n);
parc_parpool(nPar);
parfor i=1:n
    eval_dic(method,i);
end
