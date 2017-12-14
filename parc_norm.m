function x=parc_norm(x)
% demean and normalize to unit length
% 2015-6-3 08:42:58

n=size(x,2);
x=x-repmat(mean(x,2),[1,n]); % demean
x=x./repmat(sqrt(sum(x.^2,2)),[1,n]); % normalize to unit length
x(isnan(x))=0; % set the NaNs to be zeros
