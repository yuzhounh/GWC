% A graph formulated by the Gaussian of distance between voxels in the 
% graymatter mask.
% 2017-8-16 09:00:17

clear,clc;

load parc_graymatter.mat;
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