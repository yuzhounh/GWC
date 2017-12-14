function eval_num(method,i)
% actual cluster number
% 2017-7-25 21:38:44

load stat.mat;
iSub=stat(i,1);
iK=stat(i,2);

load sInfo.mat;
cSub=sSub(iSub);
cK=sK(iK);

load(sprintf('%s_sub_parc/sub%05d_K%d.mat',method,cSub,cK));
num=length(unique(img_parc))-1;
save(sprintf('%s_num/sub%05d_K%d.mat',method,cSub,cK),'num');
