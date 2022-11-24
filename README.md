## WSR maximization for RIS system

This repository contains the source codes of the Fig.4(b) in the paper ``Weighted Sum-Rate Maximization for Reconfigurable Intelligent Surface Aided Wireless Networks'' published in IEEE Transactions on Wireless Communications.

In the paper, BSUM algorithm is adopted which achieves a KKT solution for the MU-WSR problem. In addition, imperfect CSI issue is addressed by stochastic optimization.

## Introduction of the codes

### Plot fig.4(b)

Run the file ``converge_plot.m''. You may get the following figure

<img src="./fig4.jpg" height="360" width="450" >

### Generate random channel

To generate one snapshot for simulation, one may run following three files in sequence：

+ ``generate_location.m'': Random the users' locations
+ ``generate_pathloss.m'': Calucate the pathloss according to the locations
+ ``generate_channel.m''" Randomly generate the channel realizations

### Main codes for the algorithms

The following are the main code files for the 5 algorihtms shown in the figure.

+ ``without_RIS.m'': There's no RIS in the system.
+ ``RIS_phaserand.m'': The RIS adopts random phase.
+ ``converge_AO_perfect.m'': Alternating optimization approach illustrated in Section III. Note that, to support the Riemannian conjugate gradient (RCG) algorithm, one should download the Manopt toolbox from <https://www.manopt.org/> at first.
+ ``converge_A2_perfect.m'': Proposed algorithm under the perfect CSI setup.
+ ``converge_A2_imperfect.m'': Proposed algorithm under the imperfect CSI setup.

## Some of My Related Works
### IRS channel estimation
+ H. Guo and V. K. N. Lau, "Uplink Cascaded Channel Estimation for Intelligent Reflecting Surface Assisted Multiuser MISO Systems," in IEEE Transactions on Signal Processing, vol. 70, pp. 3964-3977, 2022. (see <https://ieeexplore.ieee.org/document/9839429>).

We propose a novel two-stage channel estimation protocol without the need of on-off amplitude control to avoid the reflection power loss. One may refer the source code from <https://github.com/guohuayan/IRS_Channel_Estimation>

### IRS phase shift optimization with statistical CSI
+ H. Guo, Y. -C. Liang and S. Xiao, "Intelligent Reflecting Surface Configuration With Historical Channel Observations," in IEEE Wireless Communications Letters, vol. 9, no. 11, pp. 1821-1824, Nov. 2020. (see <https://ieeexplore.ieee.org/document/9120336>). 

We propose a general IRS statistical CSI configuration algorithm, which can be adopted to any statistical CSI model even for the case when there is no LoS link between BS and IRS. One may refer the source code from <https://github.com/guohuayan/IRS_opt_statistical_CSI>

## Note
You may cite us by  
@ARTICLE{8982186,   
author={H. Guo and Y.-C. Liang and J. Chen and E. G. Larsson},   
journal={IEEE Trans. Wireless Commun.},   
title={Weighted Sum-Rate Maximization for Reconfigurable Intelligent Surface Aided Wireless Networks},   
volume = {19},
number = {5},
pages = {3064-3076},
ISSN = {1558-2248},
DOI = {10.1109/TWC.2020.2970061},
year = {2020},
type = {Journal Article}
}


One previous version of this paper is named ``Weighted Sum-Rate Optimization for Intelligent Reflecting Surface Enhanced Wireless Networks'', which can be found in ArXiv as well (see <https://arxiv.org/abs/1905.07920>). The short version has been presented in IEEE GLOBECOM 2019.

