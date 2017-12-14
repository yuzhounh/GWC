function eval_sdi(method,i)
% spatial discontiguity index
% 2017-7-25 21:38:44

load stat.mat;
iSub=stat(i,1);
iK=stat(i,2);

load sInfo.mat;
cSub=sSub(iSub);
cK=sK(iK);

load(sprintf('%s_sub_parc/sub%05d_K%d.mat',method,cSub,cK));
img_parc_new=parc_distinct(img_parc);
K_new=length(unique(img_parc_new))-1;
sdi=K_new-K;
save(sprintf('%s_sdi/sub%05d_K%d.mat',method,cSub,cK),'sdi');
