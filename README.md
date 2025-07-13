## CUDA/OpenCL/Vulkan Cluster - R&D + C&C
## Based on `Ubuntu 22.04 NVidia Docker2`
## With `Gaming` version as PoC for streaming

![](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)

System is build with `CUDA/OpenCL` nodes on top of (GPU) hosts to allow the distributed workloads layered on top of physical and/or virtual hosts. 
The Infra & monitoring should be done by invoking you favorite k8s orchestrator eg. Rancher 1.6.x or 2.x

This docker image serves as the base for applications that use OpenCL/OpenGL/Vulkan Compute abstractions and also serves as middle-ware for ThereminQ, Bonsai Nbody and Mandelbulber container images. Recently a gaming tag was added for quick PoC purposes.

### How does it work ?

Spin up the controller image and you will have a VNC WebUI with vendor/driver support and setting in an X session avaliable at port `6080`
Expose the port if you want, an SSL loadbalancer advised as `6080` will be cleartext. Default password is `00000000`

```bash
docker run --gpus all --device=/dev/kfd --device=/dev/dri:/dev/dri -d twobombs/cudacluster
````

The worker node sees the underlying hardware PCI bus X-times the amount of nodes on the host so the controller node will see an X-amount of CUDA cores. 
Both the worker and controller nodes are of the same image; a controller can therefore also work because it has the binaries and settings to do so.

This setting used to optimize the workload and usage of the GPUs, and also allows the abstract of running workload on thousands of GPU cores while only running on a small subset of those cores, therefore accurately simulating scaling. To make deployment for such environments easier one can use k3d in combination with Rancher 2.4+

This container image has drivers and/or configurations for
- AMD ( OCL & ROCm )
- Nvidia ( CUDA, Vulkan & OpenCL )
- Intel ( OCLgrind & Beignet Compute )
- CPU only OpenCL [POCL](http://portablecl.org/) 
- [VirtualCL](https://mosix.cs.huji.ac.il/) for OpenCL clusters

## Revisions:
- `v2023` upgrade to Ubuntu 22.04 and CUDA 12.1
- `v2022c` added virtualcl https://mosix.cs.huji.ac.il/txt_vcl.html
- `v2022b` vulkan: added Zink GL https://launchpad.net/~kisak/+archive/ubuntu/kisak-mesa
- `v2022a` gaming: added Sunshine for streaming https://github.com/SunshineStream/Sunshine 
- `v2021` gaming: added Wine, Steam Lutrix and Vulkan Engine in Gaming tag
- `v2020` iteration: upgraded to CUDA 11+ @ Ubuntu 20.04
- OpenCL 1.2+ drivers for the 3 main Compute vendors plus one CPU only POCL version

### Vanilla OCL version
<img width="1433" alt="Screenshot 2021-05-04 at 15 50 42" src="https://user-images.githubusercontent.com/12692227/117013928-96f99680-acf0-11eb-95cb-3427ed861a36.png">

### Vulkan/Gaming version
![Screenshot from 2021-08-30 21-10-48](https://user-images.githubusercontent.com/12692227/131392607-9abe5fed-a621-483d-9c0d-a88997c00b2d.png)


### Zink Integration
![Screenshot from 2022-07-19 11-23-29](https://user-images.githubusercontent.com/12692227/179716583-1f3f5d71-a95d-42ac-8266-a2d2cc0552d3.png)
