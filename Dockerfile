FROM twobombs/deploy-nvidia-docker

# add cl apps
RUN apt-get update&&apt-get install -y git software-properties-common ant openjdk-8-jdk qv4l2 python-setuptools python3-setuptools python-migrate && apt-get clean all
RUN git clone --recursive https://github.com/stevenrobertson/cuburn.git
RUN git clone --recursive https://github.com/mebigfatguy/apophysis-j.git
RUN cd /apophysis-j && ant 

# add moar bench apps
RUN add-apt-repository universe && apt-get update && apt-get -y --force-yes upgrade && export DEBIAN_FRONTEND=noninteractive && apt-get install -y libboost-all-dev python-pip phoronix-test-suite && apt-get clean all
RUN add-apt-repository ppa:paulo-miguel-dias/mesa -y && apt-get update && apt -y dist-upgrade && apt-get clean all
RUN pip install numpy scipy

# add CL drivers
RUN cd /root && wget http://upload.aspeedtech.com/BIOS/v103_linux_freebsd_solaris.zip && unzip /root/v103_linux_freebsd_solaris.zip
RUN cd /root &&git clone git://github.com/novnc/noVNC v1.0.0 && mv v1.0.0 noVNC && cp /root/noVNC/vnc.html /root/noVNC/index.html && mkdir /root/.vnc
RUN cd /root &&wget http://archive.ubuntu.com/ubuntu/dists/bionic/main/installer-amd64/current/images/netboot/mini.iso && wget http://www.luxrender.net/release/luxmark/v3.1/luxmark-linux64-v3.1.tar.bz2
RUN cd /root && mkdir compute && cd compute && https://github.com/intel/compute-runtime/releases/download/19.03.12192/intel-gmmlib_18.4.1_amd64.deb && https://github.com/intel/compute-runtime/releases/download/19.03.12192/intel-igc-core_19.02.1330_amd64.deb && https://github.com/intel/compute-runtime/releases/download/19.03.12192/intel-igc-opencl_19.02.1330_amd64.deb && https://github.com/intel/compute-runtime/releases/download/19.03.12192/intel-opencl_19.03.12192_amd64.deb && dpkg -i --force-all *.deb
RUN cd /root && wget https://www2.ati.com/drivers/linux/ubuntu/amdgpu-pro-17.40-492261.tar.xz && tar -xJpf amdgpu-pro-*.tar.xz

EXPOSE 6080

ENTRYPOINT /root/run
