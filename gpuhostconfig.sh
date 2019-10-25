# this script configures any GPU host for vGPU CUDA Cluster 2018 usage
# tnx go out to NV and Rancher for creating the coolest container solution on the planet

# prep
sudo add-apt-repository -y universe
sudo add-apt-repository -y multiverse
sudo add-apt-repository -y ppa:graphics-drivers/ppa
sudo apt-get update

# kernel upgrade
sudo apt-get -y install linux-image-extra-$(uname -r)

# fetch the newest docker 
sudo wget -qO- https://get.docker.com/ | sh

# get the NV drivers for connectivity to the PCIe layer
sudo apt-get -y install nvidia-375 nvidia-cuda-toolkit ubuntu-desktop
sudo apt-get -y install nvidia-modprobe
curl -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
sudo tee /etc/apt/sources.list.d/nvidia-docker.list <<< "deb https://nvidia.github.io/libnvidia-container/ubuntu16.04/amd64 deb https://nvidia.github.io/nvidia-container-runtime/ubuntu16.04/amd64 deb https://nvidia.github.io/nvidia-docker/ubuntu16.04/amd64 /"

# fetch update, install nv-dckr2.0
sudo apt-get update
sudo apt-get install nvidia-docker2
sudo pkill -SIGHUP dockerd

# fetch zerotier client for secure access to the controller ( todo: add the client to a ZT network )
curl -s https://install.zerotier.com/ | sudo bash
