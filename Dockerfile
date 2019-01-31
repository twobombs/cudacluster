FROM twobombs/deploy-nvidia-docker

# add cl apps
RUN apt-get update&&apt-get install -y git software-properties-common ant openjdk-8-jdk qv4l2 python-setuptools python3-setuptools python-migrate && apt-get clean all

# add ES repo and install Logstash for log transport
RUN apt-get install -y openjdk-8-jre apt-transport-https && wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add - && echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" > /etc/apt/sources.list.d/elastic.list && apt-get update && apt-get install -y logstash 

# add CL drivers
RUN cd /root && wget http://upload.aspeedtech.com/BIOS/v103_linux_freebsd_solaris.zip && unzip /root/v103_linux_freebsd_solaris.zip
RUN cd /root && wget http://archive.ubuntu.com/ubuntu/dists/bionic/main/installer-amd64/current/images/netboot/mini.iso && wget http://www.luxrender.net/release/luxmark/v3.1/luxmark-linux64-v3.1.tar.bz2
RUN cd /root && mkdir compute && cd compute && wget https://github.com/intel/compute-runtime/releases/download/19.03.12192/intel-gmmlib_18.4.1_amd64.deb && wget https://github.com/intel/compute-runtime/releases/download/19.03.12192/intel-igc-core_19.02.1330_amd64.deb && wget https://github.com/intel/compute-runtime/releases/download/19.03.12192/intel-igc-opencl_19.02.1330_amd64.deb && wget https://github.com/intel/compute-runtime/releases/download/19.03.12192/intel-opencl_19.03.12192_amd64.deb && dpkg -i --force-all *.deb
RUN cd /root && wget https://www2.ati.com/drivers/linux/ubuntu/amdgpu-pro-17.40-492261.tar.xz 

EXPOSE 6080

ENTRYPOINT /root/run
