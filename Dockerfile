FROM debian:bullseye
RUN mkdir -p /usr/local/minetest/
WORKDIR /usr/local/minetest

# Install game dependencies (only once)
RUN apt update && apt install -y \
    g++ ninja-build cmake libsqlite3-dev \
    libcurl4-openssl-dev zlib1g-dev libgmp-dev \
    libjsoncpp-dev libzstd-dev libncurses-dev git binutils

# Create non-root user

RUN mkdir -p /usr/local/minetest/ 
# && useradd -m client && chown -R client:client /usr/local/minetest

# Copy precompiled game binary and config for this player
COPY game /usr/local/minetest/


