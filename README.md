# CUDA/OpenCL Cluster 2020 - R&D + C&C 
# Based on Ubuntu 20.04 NVidia Docker 19.03+ CUDAGL Dev Image

![](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)

System is build with CUDA/OpenCL nodes on top of (GPU) hosts to allow the distributed workloads layered on top of physical and/or virtual hosts. 
The Infra & monitoring should be done by invoking you favorite orchestrator eg. Rancher 1.6.x or 2.x

How does it work ?

Spin up the controller image and you will have a VNC WebUI with vendor/driver support and setting in an X session avaliable at port 6080. 
Expose the port if you want, an SSL loadbalancer advised as 6080 will be cleartext.

The worker node sees the underlying hardware PCI bus X-times the amount of nodes on the host so the controller node will see an X-amount of CUDA cores. 
Both the worker and controller nodes are of the same image; a controller can therefore also work because it has the binaries and settings to do so.

This setting used to optimize the workload and usage of the GPUs, and also allows the abstract of running workload on thousands of GPU cores while only running on a small subset of those cores, therefore accurately simulating scaling. To make deployment for such environments easier one can use k3d in combination with Rancher 2.4+

This container image has drivers and/or configurations for
- AMD ( OCL & ROCm )
- Nvidia ( CUDA & OpenCL )
- Intel ( OCLgrind & Beignet Compute )
- CPU only ( POCL )

This docker image serves as the base for applications that use Compute abstractions and also server as the middle-driver-ware for QrackNET container image

- v2020 iteration: upgraded to CUDA 11+ @ Ubuntu 20.04
- OpenCL 1.2+ drivers for the 3 main Compute vendors plus one CPU only POCL version
