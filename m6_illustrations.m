% draw illustrations of the generated brain atlases
% 2015-9-4 11:31:16

clear,clc;

nii=load_untouch_nii('T1_4mm.nii');
img_bg=nii.img;
opt=1;

cSub=00440; % choose a subject ID

sM={'Ncut','SLIC','GWC'}; % M denotes method
nM=length(sM);
img_rows=[]; 
for iM=1:nM
    cM=sM(iM);
    method=cM{1,1}; % parcellation method
    
    img_row=[]; 
    sK=[50,100,400];
    nK=length(sK);
    for iK=1:nK
        cK=sK(iK);  % cluster number 
        load(sprintf('%s_sub_parc/sub%05d_K%d.mat',method,cSub,cK));
        img_orth=parc_orthview(img_bg,img_parc,opt);
        img_row=[img_row,img_orth]; % different cluster numbers in a row
    end
    
    img_rows=[img_rows;img_row]; % each row for a method
end

% display
figure;
img_rows=single(img_rows/255);
imshow(img_rows,'border','tight');

% resize
pos=get(gcf,'Position'); 
scale=1.6; 
set(gcf,'Position',[pos(1),pos(2),pos(3)*scale,pos(4)*scale]);
