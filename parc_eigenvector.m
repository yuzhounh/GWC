function y=parc_eigenvector(x)
% For each column in x, multiply it by -1 if the element with the maximum
% absolute value in it is negative. By this way, the signs of the
% eigenvectors will change arbitrarily. 
% 2017-8-15 21:49:33

[m,n]=size(x);
[~,b]=max(abs(x),[],1);
s=zeros(1,n);
for i=1:n
    s(i)=sign(x(b(i),i));
end
y=x./repmat(s,[m,1]);