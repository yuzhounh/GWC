function [riSL,nvSL]=parc_searchlight(r,shape)
% Construct a searchlight.
% Input:
%     r, radius
%     shape, cube or shpere
% Output:
%     riSL, relative indices of the voxels in the searchlight
%     nvSL, number of voxles in the searchlight
% 2014-10-17 19:59:55

fr=floor(r);
riSL=zeros((2*fr+1)^3,3);

count=0; 
if strcmp(shape,'cube')
    for i=-fr:fr
        for j=-fr:fr
            for k=-fr:fr
                count=count+1;
                riSL(count,:)=[i,j,k];
            end
        end
    end
elseif strcmp(shape,'sphere')
    for i=-fr:fr
        for j=-fr:fr
            for k=-fr:fr
                if i^2+j^2+k^2<=r^2
                    count=count+1;
                    riSL(count,:)=[i,j,k];
                end
            end
        end
    end
else
    error('Please check the shape.');
end
riSL=riSL(1:count,:);
nvSL=count;