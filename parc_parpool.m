function parc_parpool(poolsize)
% Start parpool in different cases for parallel computing. 
% 
% The poolsize is a positive integer whose upper limit is constrainted by 
% several factors. Check:
%   1) Running Code on Parallel Pools - MATLAB & Simulink - MathWorks China
%   http://t.cn/Rq5rP8P
%   2) Memory. Reduce the pool size in case of the out of memory problem. 
% 
% The function 'matlabpool' is replaced by 'parpool' in R2013b (8.2) and
% removed in R2016a (9.0). See:
% Release Notes for Parallel Computing Toolbox - MATLAB & Simulink - 
% MathWorks China http://t.cn/Rq5eJ6q
% MATLAB version - Wikipedia, the free encyclopedia http://t.cn/Rq5gI7R
% 
% This function is compatible with both 'matlabpool' and 'parpool', but the
% latter one is more suggested. 
% 
% 2015-6-2 10:11:51

v=version; % Matlab version
v=str2num(v(1:3)); 

if v>=8.2 % for Matlab R2013b or later
    % the current pool size
    poolobj = gcp('nocreate');
    if isempty(poolobj) % no pool
        parpool(poolsize);
    elseif poolsize~=poolobj.NumWorkers % If the poolsize is different, then shutdown the old pool and create a new one.
        delete(gcp);
        parpool(poolsize);
    end
else
    currentpoolsize=matlabpool('size'); % the current pool size
    if currentpoolsize==0
        matlabpool(poolsize);
    elseif poolsize~=currentpoolsize
        matlabpool('close');
        matlabpool(poolsize);
    end
end