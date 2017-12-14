% Download the NIFTI toolbox and Craddock's demo data from the web. You
% might do this manually from the links:
%     http://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image
%     https://www.nitrc.org/projects/cluster_roi/
% If so, unzip the NIFTI toolbox and add it to the Matlab search path, put
% the .tar.gz demo data in the same folder as the scripts.
% 2016-4-8 15:36:40

clear,clc;

% NIFTI toolbox, 0.42 MB
url='http://www.mathworks.com/matlabcentral/mlc-downloads/downloads/submissions/8797/versions/28/download/zip/NIfTI_20140122.zip';
filename='NIfTI_20140122.zip';
if ~exist(filename,'file')
    urlwrite(url,filename);
end

% demo data of three subjects, a graymatter mask and a brain template
% 219 MB
% From http://www.nitrc.org/projects/slic
url='http://www.nitrc.org/frs/download.php/10124/SLIC_individual_data.zip';
filename='SLIC_individual_data.zip';
if ~exist(filename,'file')
    fprintf('Begin downloading the demo data (219 MB). Please wait......\n');
    urlwrite(url,filename);
    fprintf('Completed.\n');
end