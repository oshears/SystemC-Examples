# Use a base Ubuntu image
FROM ubuntu:22.04-slim

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install necessary build tools and dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    g++ \
    make \
    cmake \
    wget \
    libtool \
    autoconf \
    automake \
    git \
    doxygen \
    gtkwave \
    graphviz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /usr/local/src

# Download the SystemC library (replace with the desired version)
# You can find the latest stable release from Accellera's website or GitHub
# For this example, we'll use a commonly available version.
# IMPORTANT: Always check for the latest stable release and update the URL.
RUN wget https://github.com/accellera-official/systemc/archive/refs/tags/3.0.1.tar.gz -O systemc-3.0.1.tgz

# Extract the SystemC archive
RUN tar -xzf systemc-3.0.1.tgz

WORKDIR /usr/local/src/systemc-3.0.1

# Build & install SystemC using CMake (avoids missing DEVELOPMENT.md autotools issue)
RUN mkdir -p build && cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local/systemc -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=17 && \
    cmake --build . -j"$(nproc)" && \
    cmake --install .

# Clean up the source directory to reduce image size
WORKDIR /usr/local/src
RUN rm -rf systemc-3.0.1 systemc-3.0.1.tgz

# Set environment variables for SystemC
ENV SYSTEMC_HOME=/usr/local/systemc
# Initialize LD_LIBRARY_PATH if it's not set, then append.
# This avoids the "UndefinedVar" warning.
ENV LD_LIBRARY_PATH=/usr/local/systemc/lib:/usr/local/systemc/lib-linux64

# Set the default command when the container starts (bash shell)
CMD ["bash"]
