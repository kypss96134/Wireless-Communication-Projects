# Wireless-Communication-Projects
This is a wireless communication project that includes three beamformers and four MIMO detectors.

Beam Former:
- MVDR
- MSINR
- MMSE
The received signal **x(k)** is generated according to the following formula:

$\mathbf{x}(k) = \mathbf{a}(\theta_0)s_p(k) + \mathbf{a}(\theta_1)s_1(k) + \mathbf{a}(\theta_2)s_2(k) + \mathbf{n}(k), \quad k=1,\dots,10^4$

where

$\mathbf{a}(\theta) = \begin{bmatrix} 1, & e^{j\pi \sin \theta}, & \dots, & e^{j(N-1)\pi \sin \theta} \end{bmatrix}^T,$

$s_p(k)$ is the pilot signal known to the receiver, \(\mathbf{n}(k)\) is AWGN, and the number of receive antennas $M = 16$.  

MIMO Detector:
- MMSE
- MMSE OSIC
- K-best Sphere
- Maximum Likelihhod (ML) 
