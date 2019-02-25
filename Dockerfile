FROM twobombs/deploy-nvidia-docker

# force yes, force install 
COPY 90forceyes /etc/apt/apt.conf.d/

# add cl dev apps & dependancies
RUN apt-get update && apt-get install -y git software-properties-common ant openjdk-8-jdk qv4l2 ocl-icd-opencl-dev python-setuptools python3-setuptools python-migrate dkms && apt-get clean all && apt -y autoremove

# add CL drivers
# Aspeed onboard
RUN cd /root && wget -q http://upload.aspeedtech.com/BIOS/v103_linux_freebsd_solaris.zip && unzip /root/v103_linux_freebsd_solaris.zip && rm *.zip
# Intel
RUN cd /root && mkdir compute && cd compute && wget -q https://github.com/intel/compute-runtime/releases/download/19.03.12192/intel-gmmlib_18.4.1_amd64.deb && wget -q https://github.com/intel/compute-runtime/releases/download/19.03.12192/intel-igc-core_19.02.1330_amd64.deb && wget https://github.com/intel/compute-runtime/releases/download/19.03.12192/intel-igc-opencl_19.02.1330_amd64.deb && wget https://github.com/intel/compute-runtime/releases/download/19.03.12192/intel-opencl_19.03.12192_amd64.deb && dpkg -i --force-all *.deb && cd ..
# moar AMD ( POCL )
RUN cd / && git clone --recursive https://github.com/twobombs/cudacluster && cd /cudacluster/amd1850 && ./amdgpu-install -y --opencl=legacy && cd / && rm -rf cudacluster/
RUN apt install libnuma-dev && wget -qO - http://repo.radeon.com/rocm/apt/debian/rocm.gpg.key | sudo apt-key add - && echo 'deb [arch=amd64] http://repo.radeon.com/rocm/apt/debian/ xenial main' | sudo tee /etc/apt/sources.list.d/rocm.list && apt update && apt -o Dpkg::Options::="--force-overwrite" install rocm-dkms && usermod -a -G video root
# NVidia
RUN add-apt-repository -y ppa:graphics-drivers/dev && apt-get update
RUN apt-get -o Dpkg::Options::="--force-overwrite" install cuda nvidia-opencl-dev && apt-get clean all
 
# Ubuntu luxmark testsuite
RUN cd /root && wget -q https://github.com/LuxCoreRender/LuxMark/releases/download/luxmark_v3.1/luxmark-linux64-v3.1.tar.bz2 && cd /

EXPOSE 6080

ENTRYPOINT /root/run
