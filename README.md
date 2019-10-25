# Generating individual atlases with whole brain resting-state fMRI data by 
learning the graph and parcellation simultaneously 
Copyright (C) 2017 Jing Wang

This toolbox includes three individual subject level whole-brain 
parcellation approaches, i.e., normalized cuts (Ncut), simple linear 
iterative clustering (SLIC), and graph-without-cut (GWC). A demo which 
applies the three approaches on the resting-state fMRI data of three 
subjects from the Beijing_Zang dataset (of the fcon_1000 project) is 
provided in this toolbox. 

## Usage:
Run main.m to play the demo. 

## Notes:
1. You may download the NIFTI toolbox and the demo data manually.
2. For parallel computing, carefully choose the number of parallel workers
   to make the most of the hardware resources and to avoid problems such
   as the out of memory problem.

## Related codes:
1. Scripts for the paper: A supervoxel-based method for groupwise whole 
   brain parcellation with resting-state fMRI data. 
      SLIC: http://www.nitrc.org/projects/slic
      SLIC: https://github.com/yuzhounh/SLIC
      SLIC_atlas: https://github.com/yuzhounh/SLIC_atlas
2. Scripts for the paper: Parcellating whole brain for individuals by 
   simple linear iterative clustering.
      SLIC_individual: https://github.com/yuzhounh/SLIC_individual

## References:
1. Jing Wang, and Haixian Wang. "A supervoxel-based method for groupwise 
   whole brain parcellation with resting-state fMRI data." Frontiers in 
   human neuroscience 10 (2016).
2. Jing Wang, Zilan Hu, and Haixian Wang. "Parcellating whole brain for 
   individuals by simple linear iterative clustering." International 
   Conference on Neural Information Processing. Springer International 
   Publishing, 2016.

## Contact information:
Jing Wang
wangjing0@seu.edu.cn
yuzhounh@163.com
2017-12-14 17:14:19
