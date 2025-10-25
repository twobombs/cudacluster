# CUDA/OpenCL/Vulkan Cluster

## Overview

This repository provides a set of Docker images for building a distributed computing cluster with support for CUDA, OpenCL, and Vulkan. The images are based on Ubuntu and are designed to work with NVIDIA, AMD, and Intel GPUs. The cluster can be used for a variety of purposes, including research and development, high-performance computing, and gaming.

## Features

-   **Multi-GPU Support**: Works with NVIDIA, AMD, and Intel GPUs.
-   **Multiple Compute APIs**: Supports CUDA, OpenCL, and Vulkan.
-   **Distributed Workloads**: Allows for distributed workloads across multiple nodes.
-   **VNC Web UI**: Provides a VNC web UI for easy access to the controller node.
-   **Gaming Support**: Includes a "gaming" version with support for Wine, Steam, and Lutris.

## Docker Images

This repository contains several Dockerfiles for building different versions of the `cudacluster` image. Each image is designed for a specific purpose and includes a different set of dependencies and configurations.

### `cudacluster:latest` (`Dockerfile`)

This is the base image for the `cudacluster`. It includes the necessary dependencies for running CUDA and OpenCL applications, as well as the NVIDIA Docker runtime.

**Dependencies:**
- `git`
- `software-properties-common`
- `ant`
- `freeglut3-dev`
- `openjdk-8-jdk`
- `qv4l2`
- `ocl-icd-libopencl1`
- `opencl-headers`
- `ocl-icd-opencl-dev`
- `oclgrind`
- `python3-setuptools`
- `dkms`
- `intel-gpu-tools`
- `nvidia-docker2`
- `docker.io`

**Configuration:**
- Installs the NVIDIA Docker runtime.
- Sets up the NVIDIA OpenCL ICD.
- Exposes ports `255` and `6080`.
- Sets the entrypoint to `/root/run`.

### `cudacluster:dev` (`Dockerfile-dev`)

This image is designed for development and includes a variety of development tools and libraries, as well as support for Intel GPUs.

**Dependencies:**
- All dependencies from the base image.
- Intel Compute Runtime drivers.

**Configuration:**
- Installs the Intel Compute Runtime drivers.
- Clones the `cudacluster` repository.
- Sets up the NVIDIA OpenCL ICD.
- Exposes ports `255` and `6080`.
- Sets the entrypoint to `/root/run`.

### `cudacluster:gaming` (`Dockerfile-gaming`)

This image is designed for gaming and includes support for Wine, Steam, and Lutris, as well as the Vulkan graphics API.

**Dependencies:**
- All dependencies from the `vulkan` image.
- `winehq-stable`
- `steam`

**Configuration:**
- Adds the WineHQ repository.
- Installs Wine and Steam.
- Exposes port `6080`.
- Sets the entrypoint to `/root/run`.

### `cudacluster:hpc` (`Dockerfile-hpc`)

This image is designed for high-performance computing and includes the NVIDIA HPC SDK.

**Dependencies:**
- `curl`
- `nvhpc-22-9-cuda-multi`

**Configuration:**
- Installs the NVIDIA HPC SDK.
- Exposes port `6080`.
- Sets the entrypoint to `/root/run`.

### `cudacluster:vulkan` (`Dockerfile-vulkan`)

This image is designed for Vulkan development and includes the Vulkan SDK and validation layers.

**Dependencies:**
- All dependencies from the `dev` image.
- `vulkan-tools`
- `libvulkan-dev`
- `cmake`
- `cargo`
- `pkg-config`
- `libclang-dev`

**Configuration:**
- Installs the Vulkan SDK and validation layers.
- Clones and builds the Vulkan-ValidationLayers, Vulkan-Headers, and Vulkan-Loader repositories.
- Installs the `vulkan-device-filter`.
- Copies the `nvidia_icd.json` file to the appropriate location.

### `cudacluster:2204dev` (`Dockerfile2204-dev`)

This is a development image based on Ubuntu 22.04. It includes support for AMD ROCm drivers and Intel OpenCL ICD.

**Dependencies:**
- All dependencies from the base image.
- `rocm`
- `radeontop`
- `intel-opencl-icd`

**Configuration:**
- Installs the AMD ROCm drivers.
- Sets up the AMD and NVIDIA OpenCL ICDs.
- Installs the Intel OpenCL ICD.
- Installs `koboldcpp`.
- Exposes ports `255` and `6080`.
- Sets the entrypoint to `/root/run`.

## Usage

To use the `cudacluster` images, you can either build them from the Dockerfiles in this repository or pull them from Docker Hub.

### Building from Source

To build the images from source, clone this repository and run the `docker build` command for the desired image. For example, to build the base image, run the following command:

```bash
docker build -t cudacluster:latest .
```

### Running the Container

To run a container, use the `docker run` command with the appropriate options. For example, to run the base image with GPU support, use the following command:

```bash
docker run --gpus all --device=/dev/kfd --device=/dev/dri:/dev/dri -d cudacluster:latest
```

This will start a container in detached mode with access to all available GPUs. You can then access the VNC web UI at `http://localhost:6080`. The default password is `00000000`.

### Worker Nodes

The worker nodes use the same image as the controller node. When a worker node is started, it will automatically connect to the controller and become part of the cluster.

### AMD GPU Setup (`run-amd`)

The `run-amd` script is used to set up AMD GPUs for use with OpenCL. It installs the necessary drivers and libraries and configures the system for use with AMD GPUs.

**Dependencies:**
- `mesa-opencl-icd`
- `dialog`
- `clinfo`

**Configuration:**
- Installs the AMD GPU drivers.
- Creates a symbolic link for the OpenCL library.

### Vulkan Installation (`install_vulkan.sh`)

The `install_vulkan.sh` script is used to install the Vulkan SDK and validation layers. It also configures the system for use with Vulkan.

**Dependencies:**
- `vulkan-utils`
- `cmake`
- `python3`
- `wget`

**Configuration:**
- Installs the Vulkan SDK and validation layers.
- Clones and builds the Vulkan-ValidationLayers, Vulkan-Headers, and Vulkan-Loader repositories.
- Copies the `nvidia_icd.json` file to the appropriate location.

## Configuration

The environment is configured using a combination of Docker environment variables and configuration files.

### NVIDIA ICD (`nvidia_icd.json`)

The `nvidia_icd.json` file is used to configure the NVIDIA OpenCL ICD. It specifies the path to the NVIDIA OpenCL library and the API version to use.

## Revisions

-   **v2023**: Upgrade to Ubuntu 22.04 and CUDA 12.1
-   **v2022c**: Added virtualcl
-   **v2022b**: Added Zink GL
-   **v2022a**: Added Sunshine for streaming
-   **v2021**: Added Wine, Steam, Lutrix, and Vulkan Engine in Gaming tag
-   **v2020**: Upgraded to CUDA 11+ @ Ubuntu 20.04
-   OpenCL 1.2+ drivers for the 3 main Compute vendors plus one CPU only POCL version
