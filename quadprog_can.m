function x=quadprog_can(v)
% Quadratic programming problem. 
%
% Input: v, a vector with size n*1
% Output: x, a vector with size n*1
%
% Optimization problem:
%     min norm(x-v)^2/2
%     s.t. x>=0
%          x'*ones(n,1)=1
% 
% References: 
% [1] Nie, Feiping, Xiaoqian Wang, and Heng Huang. "Clustering and 
% projected clustering with adaptive neighbors." In Proceedings of the 20th 
% ACM SIGKDD international conference on Knowledge discovery and data 
% mining, pp. 977-986. ACM, 2014.
% [2] Boyd, Stephen, and Lieven Vandenberghe. Convex optimization. 
% Cambridge university press, 2004.
%
% Related codes:
% [1] http://www.escience.cn/people/fpnie/index.html (CAN)
% [2] http://cvxr.com/cvx/ (The CVX toolbox)
% [3] https://cn.mathworks.com/help/optim/ug/quadprog.html (Matlab)
%
% Jing Wang
% 2017-5-17 15:59:34

eta=-mean(v); % Lagrangian multiplier, guarantee the initial k>0
eps=1; % tolerance
iter=0; % iteration number 
while eps>1e-4 % check for convergence 
    k=sum(v+eta>0); % number of positive elements in v+eta
    v_sort=sort(v,'descend');
    eta_new=1/k-mean(v_sort(1:k)); % update eta
    eps=abs(eta-eta_new);
    eta=eta_new;
    iter=iter+1;
end
x=max(v+eta,0);