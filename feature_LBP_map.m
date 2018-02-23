function [x_LBP, x_card]=feature_LBP_map(x)
% Calculate 3D LBP according to (Montagne et al., 2013). Map the six 
% binary code to LBP(3D,6,1) code. There are ten potential classes totally.
% Input:
%     x, six binary code, e.g., [0,1,0,1,0,1]
% Output:
%     x_LBP, LBP(3D,6,1) code, 1~10
%     x_card, the cardinality of x, 0~6
% 2017-3-15 09:20:58

% cardinality
x_card=sum(x);

% create a searchlight
r=1;
shape='sphere';
[riSL,nvSL]=parc_searchlight(r,shape);
riSL(4,:)=[]; % take out the center point

% LBP coding
if x_card==0
    x_LBP=1;
elseif x_card==1
    x_LBP=2;
elseif x_card==2
    tmp=riSL(find(x),:);
    tmp=sum((tmp(1,:)-tmp(2,:)).^2);
    if tmp==4
        x_LBP=3;
    elseif tmp==2
        x_LBP=4;
    end
elseif x_card==3
    tmp=riSL(find(x),:);
    tmp=sum((tmp(1,:)-tmp(2,:)).^2)+sum((tmp(2,:)-tmp(3,:)).^2)+sum((tmp(3,:)-tmp(1,:)).^2);
    if tmp==8
        x_LBP=5;
    elseif tmp==6
        x_LBP=6;
    end
elseif x_card==4
    tmp=riSL(find(~x),:);
    tmp=sum((tmp(1,:)-tmp(2,:)).^2);
    if tmp==4
        x_LBP=7;
    elseif tmp==2
        x_LBP=8;
    end
elseif x_card==5
    x_LBP=9;
elseif x_card==6
    x_LBP=10;
end