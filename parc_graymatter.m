% 2017-7-8 22:51:48

% the information of the graymatter
file_mask='graymatter.nii';
nii=load_untouch_nii(file_mask);
img_gray=double(nii.img);
msk_gray=img_gray~=0;
ind_gray=find(msk_gray);
num_gray=length(ind_gray);
siz=size(msk_gray);
save('parc_graymatter.mat','msk_gray','ind_gray','num_gray','siz');

% A graph formulated by the Gaussian of distance between voxels in the 
% graymatter mask.
tmp=zeros(num_gray,3);
for i=1:num_gray
    [a,b,c]=ind2sub(siz,ind_gray(i));
    tmp(i,:)=[a,b,c];
end
D=pdist(tmp);
D=D/median(D);
D=exp(-D.^2);
D=squareform(D);
save('parc_distance.mat','D','-v7.3');