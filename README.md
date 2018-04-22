# CUDA/OpenCL Cluster 2018
# Container-based cluster scripts to run and control diverse CUDA/OpenCL workloads

![](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)

System is build with CUDA/OpenCL nodes on top of (GPU) hosts to allow the distributed workloads layered on top of physical or virtual hosts. The Infra & monitoring will be done by invoking rancher 1.6x or 2.x 

The worker node sees the underlying hardware PCI bus X-times the amount of nodes on the host so the controller node will see an X-amount of CUDA cores. Both the worker and controller node are of the same image; a controller can therefore also work.

This is used to optimize the workload and usage of the GPUs, and also allows the abstract of running workload on thousands of GPU cores while only running on a small subset of those cores, therefore accurately simulating scaling.

This is a solution that came up when developing a sandbox solution for Quantum Computing. 

Project has its base from the deploy-nvidia-cuda environment with added OpenCL functionality. 

This docker image is here for preparation purposes.

Experimental:
- Import feed ( qv4l2 )

Todo:
- Sync mechnism for all the nodes ( DB & ES )
