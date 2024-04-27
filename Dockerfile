FROM twobombs/deploy-nvidia-docker

# force yes, force install 
COPY 90forceyes /etc/apt/apt.conf.d/

# add cl dev apps & dependancies
RUN apt-get update && apt-get install -y git software-properties-common ant freeglut3-dev openjdk-8-jdk qv4l2 ocl-icd-libopencl1 opencl-headers ocl-icd-opencl-dev oclgrind python-setuptools python3-setuptools dkms intel-gpu-tools && apt-get clean all && apt -y autoremove

RUN git clone https://github.com/twobombs/cudacluster.git
# install nvidia-docker bins for controller
RUN curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey |  apt-key add - 
RUN curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu20.04/nvidia-docker.list | tee /etc/apt/sources.list.d/nvidia-docker.list
RUN apt-get update && apt-get install -y nvidia-docker2 docker.io && apt-get clean all

# NVidia hw integration
RUN mkdir -p /etc/OpenCL/vendors && echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute

EXPOSE 255 6080
ENTRYPOINT /root/run
