FROM twobombs/deploy-nvidia-docker

# add cl apps
RUN apt-get update && apt-get install -y git software-properties-common ant openjdk-8-jdk qv4l2 python-setuptools python3-setuptools python-migrate dkms && apt-get clean all

# add CL drivers
# Aspeed onboard
RUN cd /root && wget http://upload.aspeedtech.com/BIOS/v103_linux_freebsd_solaris.zip && unzip /root/v103_linux_freebsd_solaris.zip
# Intel
RUN cd /root && mkdir compute && cd compute && wget https://github.com/intel/compute-runtime/releases/download/19.03.12192/intel-gmmlib_18.4.1_amd64.deb && wget https://github.com/intel/compute-runtime/releases/download/19.03.12192/intel-igc-core_19.02.1330_amd64.deb && wget https://github.com/intel/compute-runtime/releases/download/19.03.12192/intel-igc-opencl_19.02.1330_amd64.deb && wget https://github.com/intel/compute-runtime/releases/download/19.03.12192/intel-opencl_19.03.12192_amd64.deb && dpkg -i --force-all *.deb
# AMD
RUN cd / && git clone --recursive https://github.com/twobombs/cudacluster && cd /cudacluster/amd && dpkg -i amdgpu-pro-core_17.40-514569_all.deb && dpkg -i libopencl1-amdgpu-pro_17.40-514569_amd64.deb && dpkg -i clinfo-amdgpu-pro_17.40-514569_amd64.deb && dpkg -i opencl-amdgpu-pro-icd_17.40-514569_amd64.deb && dpkg -i amdgpu-pro-dkms_17.40-514569_all.deb && dpkg -i libdrm2-amdgpu-pro_2.4.82-514569_amd64.deb && dpkg -i ids-amdgpu-pro_1.0.0-514569_all.deb && dpkg -i libdrm-amdgpu-pro-amdgpu1_2.4.82-514569_amd64.deb && cd / 

# Ubuntu boot-iso & testsuite
RUN cd /root && wget http://archive.ubuntu.com/ubuntu/dists/bionic/main/installer-amd64/current/images/netboot/mini.iso && wget http://www.luxrender.net/release/luxmark/v3.1/luxmark-linux64-v3.1.tar.bz2 && cd /

EXPOSE 6080

ENTRYPOINT /root/run
