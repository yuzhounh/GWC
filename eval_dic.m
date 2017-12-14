function eval_dic(method,i)
% Dice coeffcient
% 2017-7-25 22:07:44

load stat_dice.mat;
cSub1=stat_dice(i,1);
cSub2=stat_dice(i,2);
cK=stat_dice(i,3);

load sInfo.mat;

load parc_graymatter.mat;
nM=num_gray;

load(sprintf( '%s_sub_parc/sub%05d_K%d.mat',method,cSub1,cK));
A=img_parc(msk_gray);
 
load(sprintf( '%s_sub_parc/sub%05d_K%d.mat',method,cSub2,cK));
B=img_parc(msk_gray);

SA=0;
SB=0;
SC=0;
tic;
for i=1:nM
    for j=1:nM
        if A(i)==A(j)
            SA=SA+1;
        end
       
        if B(i)==B(j)
            SB=SB+1;
        end
       
        if A(i)==A(j) && B(i)==B(j)
            SC=SC+1;
        end
    end
    perct(toc,i,nM,10);
end
 
% Dice's coefficient
dic=(2*SC-2*nM)/(SA+SB-2*nM);
save(sprintf('%s_dic/sub%05d_sub%05d_K%d.mat',method,cSub1,cSub2,cK),'dic');