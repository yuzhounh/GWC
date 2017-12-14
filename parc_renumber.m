function img_parc=parc_renumber(img_parc)
% renumber the labels to be consecutive numbers
% 2017-6-13 11:15:13

% renumber regions
img_tmp=img_parc;
sLabel=unique(img_parc);
nLabel=length(sLabel);
for iLabel=2:nLabel % consider labels other than 0
    cLabel=sLabel(iLabel);
    img_tmp(img_parc==cLabel)=iLabel-1;
end
img_parc=img_tmp;