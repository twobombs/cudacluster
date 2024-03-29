# add NVulkan
apt update && apt install -y --no-install-recommends vulkan-utils cmake ca-certificates libegl1-mesa-dev libdrm-intel1 libdrm-dev libxkbcommon-dev libwayland-dev libx11-xcb-dev libxkbcommon-dev libxrandr-dev python3 python3-distutils wget && apt clean all && rm -rf /var/lib/apt/lists/*
ln -s /usr/bin/python3 /usr/bin/python
# make driver
git clone https://github.com/KhronosGroup/Vulkan-ValidationLayers.git && cd /Vulkan-ValidationLayers && mkdir build && cd build && ../scripts/update_deps.py && cmake -C helper.cmake -DCMAKE_BUILD_TYPE=Release .. && cmake --build . && make install && ldconfig
git clone https://github.com/KhronosGroup/Vulkan-Headers.git && cd /Vulkan-Headers && mkdir build && cd build && cmake -DCMAKE_INSTALL_PREFIX=install .. && make install && ldconfig 
git clone https://github.com/KhronosGroup/Vulkan-Loader.git && cd /Vulkan-Loader && mkdir build && cd build && cmake -DVULKAN_HEADERS_INSTALL_DIR=/Vulkan-Headers/build/install .. && make install && ldconfig
mkdir -p /usr/local/include/vulkan && cp -r /Vulkan-Headers/build/install/include/vulkan/* /usr/local/include/vulkan && mkdir -p /usr/local/share/vulkan/registry && cp -r /Vulkan-Headers/build/install/share/vulkan/registry/* /usr/local/share/vulkan/registry
rm -R /Vulkan-ValidationLayers && rm -R /Vulkan-Headers && rm -R /Vulkan-Loader 
# add Vulkan ICD link - check ZINK output
COPY nvidia_icd.json /etc/vulkan/icd.d/nvidia_icd.json
# RUN __GLX_VENDOR_LIBRARY_NAME=mesa MESA_LOADER_DRIVER_OVERRIDE=zink GALLIUM_DRIVER=zink glxinfo 
