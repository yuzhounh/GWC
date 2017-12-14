function [S,alphas]=GWC_S(V,k)
% update S when fixing Z and alpha
% tune k instead of beta, as in CAN
% 2017-5-15 21:32:22

n=size(V,1);
S=zeros(n);
alphas=zeros(n,1);
for i=1:n
    v=V(:,i);
    ix=setdiff([1:n],i); % take out the diagonal element
    v=v(ix);
    [s,alpha]=quadprog_can_explicit(v,k);
    S(ix,i)=s; % put it the right place 
    alphas(i,1)=alpha;
end
