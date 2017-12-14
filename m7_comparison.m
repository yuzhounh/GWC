% compare the evaluation results between the three parcellation methods
% 2017-8-17 09:00:40

clear,clc;
load sInfo.mat;
figure;

% spatial discontiguity index
subplot(1,3,1);
load parc_Ncut.mat;
plot(stat(:,1),stat(:,2),'-o','LineWidth',1.2,'MarkerSize',8);
hold on;
load parc_SLIC.mat;
plot(stat(:,1),stat(:,2),'-o','LineWidth',1.2,'MarkerSize',8);
load parc_GWC.mat;
plot(stat(:,1),stat(:,2),'-o','LineWidth',1.2,'MarkerSize',8);
legend('Ncut','SLIC','GWC','location','northeast');
xlabel('K');
ylabel('Spatial discontiguity index');
xlim([0,520]);

% homogeneity
subplot(1,3,2);
load parc_Ncut.mat;
plot(stat(:,1),stat(:,3),'-o','LineWidth',1.2,'MarkerSize',8);
hold on;
load parc_SLIC.mat;
plot(stat(:,1),stat(:,3),'-o','LineWidth',1.2,'MarkerSize',8);
load parc_GWC.mat;
plot(stat(:,1),stat(:,3),'-o','LineWidth',1.2,'MarkerSize',8);
legend('Ncut','SLIC','GWC','location','southeast');
xlabel('K');
ylabel('Homogeneity');
xlim([0,520]);

% dice
subplot(1,3,3);
load parc_Ncut.mat;
plot(stat(:,1),stat(:,4),'-o','LineWidth',1.2,'MarkerSize',8);
hold on;
load parc_SLIC.mat;
plot(stat(:,1),stat(:,4),'-o','LineWidth',1.2,'MarkerSize',8);
load parc_GWC.mat;
plot(stat(:,1),stat(:,4),'-o','LineWidth',1.2,'MarkerSize',8);
legend('Ncut','SLIC','GWC','location','southeast');
xlabel('K');
ylabel('Dice');
xlim([0,520]);

% resize
pos=get(gcf,'Position'); 
scale=0.6; 
set(gcf,'Position',[pos(1),pos(2),pos(3)*scale*3,pos(4)*scale]);