function [x,alpha]=quadprog_can_explicit(v,k)
% Quadratic programming problem.
%
% Input: v, a vector with size n*1
%        k, scalar, the number of nonzero elements in x
% Output: x, a vector with size n*1
%
% Optimization problem:
%     min norm(x-v/alpha)^2/2
%     s.t. x>=0
%          x'*ones(n,1)=1
% wherein alpha is tuning parameter. We could fix the sparsity of x, i.e.,
% the value k, in order to tune alpha. By this way, the above optimization
% problem has an explicit solution. Therefore, there would be no iteration
% in solving this problem. Be attention that alpha should be positive when
% formulating this problem. 
%
% References:
% [1] Nie, Feiping, Xiaoqian Wang, and Heng Huang. "Clustering and
% projected clustering with adaptive neighbors." In Proceedings of the 20th
% ACM SIGKDD international conference on Knowledge discovery and data
% mining, pp. 977-986. ACM, 2014.
%
% Related codes:
% [1] http://www.escience.cn/people/fpnie/index.html (CAN)
%
% Jing Wang
% 2017-5-17 15:59:34

n=length(v);
if k<=0
    error('k should be a positive integer.');
elseif k<n
    v_sort=sort(v,'descend'); % sort v by descending order
    beta=v_sort(k+1); % the (k+1)th element in v_sort
    gamma=mean(v_sort(1:k)); % the mean value of the first k elements in v_sort
    alpha=k*(gamma-beta); % alpha is determined here
    delta=1/k-gamma/alpha;
    x=max(delta+v/alpha,0);
elseif k==n
    beta=min(v);
    gamma=mean(v);
    alpha=n*(gamma-beta);
    delta=1/n-gamma/alpha;
    x=max(delta+v/alpha,0); 
else
    error('k should be less than the length of v.');
end
