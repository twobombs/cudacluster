# CUDA Cluster 2018
# Container-based cluster scripts to run and control diverse CUDA workloads ( vCPU vs. vGPU )

System is build with CUDA nodes on top of GPU hosts to allow the distributed workloads layered on top of physical hosts. Infra & monitoring is done by invoking rancher:preview

The worker node sees the underlying hardware PCI bus X-times the amount of nodes on the host so the controller node will see an X-amount of CUDA cores. Both the worker and controller node are of the same image; a controller can therefore also work.

This is used to optimize the workload and usage of the GPUs, and also allows the abstract of running workload on thousands of GPU cores while only running on a small subset of those cores, therefore accurately simulating scaling.

This is a solution that came up when developing an emulator for Quantum Computing. 

Project has its base from the deploy-nvidia-cuda environment. The docker image is here for preparation purposes.
