function SDI=parc_sdi(img_parc)
% spatial discontiguity index
% 2017-6-9 19:09:25

K0=length(unique(img_parc))-1;
img_parc=parc_relabel(img_parc);
K=length(unique(img_parc))-1;
SDI=K-K0;