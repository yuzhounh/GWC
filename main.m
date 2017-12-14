% the main script
% 2017-7-26 19:44:49

clear,clc,close all;

m0_download;        % download toolbox and demo data
m1_unzip;           % unzip the toolbox and demo data
m2_precomputation;  % some precomputations
m3_preparcellation; % some calculations before parcellation
m4_parcellation;    % parcellation by the three approaches
m5_evaluation;      % calculate and plot the evaluation metrics
m6_illustrations;   % draw illustrations
m7_comparison;      % a comparison between the three approaches