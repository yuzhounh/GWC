function alpha=GWC_alpha(v)
% update alpha when fixing Z and S
% 2017-5-15 21:45:29

alpha=quadprog_can(v);