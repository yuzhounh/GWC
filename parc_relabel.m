function img_parc=parc_relabel(img_parc)
% Make regions distinct and then relabel. Zero for background and 
% positive integers for clusters in img. 
% 2014-10-25 21:38:24

sLabel=unique(img_parc);
nLabel=length(sLabel);
maxLabel=max(sLabel);
for iLabel=2:nLabel % consider labels other than 0
    % binary image with the current label
    cLabel=sLabel(iLabel);
    bw=img_parc==cLabel;
    
    % count the number of clusters with the current label and assign a
    % label to each cluster
    conn=26; % 26 connectivity
    [L,NUM]=bwlabeln(bw,conn);
    nCluster=NUM;
    label_map=L;
    if nCluster>1
        for iCluster=2:nCluster
            maxLabel=maxLabel+1;
            ix=label_map==iCluster;
            img_parc(ix)=maxLabel;
        end
    end
end

% renumber regions
img_tmp=img_parc;
sLabel=unique(img_parc);
nLabel=length(sLabel);
for iLabel=2:nLabel % consider labels other than 0
    cLabel=sLabel(iLabel);
    img_tmp(img_parc==cLabel)=iLabel-1;
end
img_parc=img_tmp;