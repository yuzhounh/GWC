function parc_plot(method)
% plot the evaluation results for a method
% 2017-12-14 16:16:27

figure;
load sInfo.mat;

%% num
for iSub=1:nSub
    for iK=1:nK
        cSub=sSub(iSub);
        cK=sK(iK);
        load(sprintf('%s_num/sub%05d_K%d.mat',method,cSub,cK));
        tmp(iK,iSub)=num;
    end
end
stat(:,1)=mean(tmp,2);

%% sdi
for iSub=1:nSub
    for iK=1:nK
        cSub=sSub(iSub);
        cK=sK(iK);
        load(sprintf('%s_sdi/sub%05d_K%d.mat',method,cSub,cK));
        tmp(iK,iSub)=sdi;
    end
end
stat(:,2)=mean(tmp,2);

subplot(1,3,1);
plot(sK,mean(tmp,2),'-o','LineWidth',1.2,'MarkerSize',8);
xlabel('K');
ylabel('Spatial discontiguity index');

%% homogeneity
for iSub=1:nSub
    for iK=1:nK
        cSub=sSub(iSub);
        cK=sK(iK);
        load(sprintf('%s_hom/sub%05d_K%d.mat',method,cSub,cK));
        tmp(iK,iSub)=hom;
    end
end
stat(:,3)=mean(tmp,2);

subplot(1,3,2);
plot(sK,mean(tmp,2),'-o','LineWidth',1.2,'MarkerSize',8);
xlabel('K');
ylabel('Homogeneity');

%% dice
load stat_dice.mat;
n=size(stat_dice,1);
for i=1:n
    cSub1=stat_dice(i,1);
    cSub2=stat_dice(i,2);
    cK=stat_dice(i,3);
    iK=stat_dice(i,4);
    iPair=stat_dice(i,5);
    load(sprintf('%s_dic/sub%05d_sub%05d_K%d.mat',method,cSub1,cSub2,cK));
    tmp(iK,iPair)=dic;
end
stat(:,4)=mean(tmp,2);

subplot(1,3,3);
plot(sK,mean(tmp,2),'-o','LineWidth',1.2,'MarkerSize',8);
xlabel('K');
ylabel('Dice');

%% resize
pos=get(gcf,'Position'); 
scale=0.6; 
set(gcf,'Position',[pos(1),pos(2),pos(3)*scale*3,pos(4)*scale]);

%% results
save(sprintf('parc_%s.mat',method),'stat');