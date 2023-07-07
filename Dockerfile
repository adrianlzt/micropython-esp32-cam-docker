FROM ubuntu:kinetic-20230624
ARG MICROPYTHON_COMMIT=813d559bc098eeaa1c6e0fa1deff92e666c0b458

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libreadline-dev \
    libffi-dev \
    git \
    pkg-config \
    gcc-arm-none-eabi \
    libnewlib-arm-none-eabi \
    libusb-1.0-0-dev \
    cmake \
    python3-pip \
    python3-venv \
    wget \
    curl \
    vim

# Download micropython, checkout to the commit specified in MICROPYTHON_COMMIT and build mpy-cross
WORKDIR /root
RUN git clone --recursive https://github.com/micropython/micropython.git
WORKDIR /root/micropython
RUN git checkout $MICROPYTHON_COMMIT && \
    git submodule update --init --recursive
RUN make -C mpy-cross

# Clone esp-idf repo version 5.0.2, version specified in
# https://github.com/micropython/micropython/blob/813d559bc098eeaa1c6e0fa1deff92e666c0b458/ports/esp32/README.md?plain=1#L50
WORKDIR /root
RUN git clone -b v5.0.2 --recursive https://github.com/espressif/esp-idf.git
WORKDIR /root/esp-idf
RUN ./install.sh

# Build micropython for esp32
WORKDIR /root/micropython/ports/esp32
RUN bash -c "source /root/esp-idf/export.sh && \
    idf.py build"

# Entrypoint to set up environment variables and run idf.py
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["idf.py", "--help"]
COPY docker-entrypoint.sh /docker-entrypoint.sh
