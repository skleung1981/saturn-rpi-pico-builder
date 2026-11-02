FROM ubuntu:24.04

ARG PICO_SDK_VERSION=2.3.1
ARG PICOTOOL_VERSION=2.3.1
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
      vim cmake ninja-build make git python3 ca-certificates \
      gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib \
      build-essential pkg-config libusb-1.0-0-dev \
    && rm -rf /var/lib/apt/lists/*

# Pico SDK + submodules
RUN git clone --depth 1 --branch ${PICO_SDK_VERSION} \
      --recurse-submodules --shallow-submodules \
      https://github.com/raspberrypi/pico-sdk.git /opt/pico-sdk
ENV PICO_SDK_PATH=/opt/pico-sdk

# build picotool
RUN git clone --depth 1 --branch ${PICOTOOL_VERSION} \
      https://github.com/raspberrypi/picotool.git /tmp/picotool \
 && cmake -S /tmp/picotool -B /tmp/picotool/build -G Ninja \
      -DCMAKE_INSTALL_PREFIX=/opt/picotool \
 && cmake --build /tmp/picotool/build \
 && cmake --install /tmp/picotool/build \
 && rm -rf /tmp/picotool
ENV PATH=/opt/picotool/bin:$PATH
ENV picotool_DIR=/opt/picotool/lib/cmake/picotool
