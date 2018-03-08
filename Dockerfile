FROM twobombs/deploy-nvidia-docker

RUN apt-get update&&apt-get install -y git software-properties-common ant openjdk-8-jdk python-software-properties python-setuptools python3-setuptools python-migrate && apt-get clean all

RUN git clone --recursive https://github.com/stevenrobertson/cuburn.git
RUN git clone --recursive https://github.com/mebigfatguy/apophysis-j.git

RUN cd /apophysis-j && ant 

RUN add-apt-repository universe && apt-get update && apt-get -y --force-yes upgrade && export DEBIAN_FRONTEND=noninteractive && apt-get install -y libboost-all-dev python-pip && apt-get clean all

RUN NVIDIA_GPGKEY_SUM=d1be581509378368edeec8c1eb2958702feedf3bc3d17011adbf24efacce4ab5 && \
    NVIDIA_GPGKEY_FPR=ae09fe4bbd223a84b2ccfce3f60f4b3d7fa2af80 && \
    apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub && \
    apt-key adv --export --no-emit-version -a $NVIDIA_GPGKEY_FPR | tail -n +5 > cudasign.pub && \
    echo "$NVIDIA_GPGKEY_SUM  cudasign.pub" | sha256sum -c --strict - && rm cudasign.pub && \
    echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/cuda.list

RUN apt-get update && apt-get install -y --no-install-recommends \
        cuda-core-$CUDA_PKG_VERSION \
        cuda-misc-headers-$CUDA_PKG_VERSION \
        cuda-command-line-tools-$CUDA_PKG_VERSION \
        cuda-nvrtc-dev-$CUDA_PKG_VERSION \
        cuda-nvml-dev-$CUDA_PKG_VERSION \
        cuda-nvgraph-dev-$CUDA_PKG_VERSION \
        cuda-cusolver-dev-$CUDA_PKG_VERSION \
        cuda-cublas-dev-8-0=8.0.61.2-1 \
        cuda-cufft-dev-$CUDA_PKG_VERSION \
        cuda-curand-dev-$CUDA_PKG_VERSION \
        cuda-cusparse-dev-$CUDA_PKG_VERSION \
        cuda-npp-dev-$CUDA_PKG_VERSION \
        cuda-cudart-dev-$CUDA_PKG_VERSION \
        cuda-driver-dev-$CUDA_PKG_VERSION && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /usr/local/cuda && export CUDA_ROOT=/usr/local/cuda && git clone --recursive http://git.tiker.net/trees/pycuda.git && cd /pycuda && ./configure.py && make && make install

RUN pip install numpy scipy

EXPOSE 6080
