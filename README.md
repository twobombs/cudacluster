# CUDA/OpenCL Cluster 2019 - R&D + C&C 
# Based on Ubuntu 18.04 NVidia Docker2 CUDAGL Dev Image

![](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)

System is build with CUDA/OpenCL nodes on top of (GPU) hosts to allow the distributed workloads layered on top of physical and/or virtual hosts. The Infra & monitoring will be done by invoking rancher 1.6.x or 2.x

How does it work ?

Spin up this Image and you will have the the VNC UI at port 6080. This is currently the default for any worker node.

The worker node sees the underlying hardware PCI bus X-times the amount of nodes on the host so the controller node will see an X-amount of CUDA cores. Both the worker and controller node are of the same image; a controller can therefore also work.

This is used to optimize the workload and usage of the GPUs, and also allows the abstract of running workload on thousands of GPU cores while only running on a small subset of those cores, therefore accurately simulating scaling.

This container image has drivers for

- AMD ( POCL & ROCm )
- Nvidia ( CUDA & OpenCL )
- Intel ( Beignet & Compute )

This docker image serves as the base for applications that use Compute abstractions.

Done:
- v2019 iteration: upgraded to CUDA 9.2 @ Ubuntu 18.04
- OpenCL 1.2+ drivers for the 3 main Compute vendors

Todo:
- Elastic Sync mechnism for nodes ( currently: MetricBeat integration )
