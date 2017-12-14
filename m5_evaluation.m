% plot the evaluation metrics
% 2017-12-14 16:11:26

clear,clc,close all;

sM={'Ncut','SLIC','GWC'}; % methods
nM=length(sM);
for iM=1:nM
    cM=sM(iM);
    method=cM{1,1};
    parc_eval(method);
    parc_plot(method);
end