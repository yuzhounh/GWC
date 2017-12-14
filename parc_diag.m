function [W,nEmpty]=parc_diag(W)
% For empty rows, set the diagonal elements to be ones
% 2015-11-6 22:19:42

tmp=W==0;
tmp=prod(tmp,2);
ix=find(tmp);
nEmpty=length(ix);
for i=1:nEmpty
    W(ix(i),ix(i))=1;
end