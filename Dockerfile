LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.description="Up to date CUDA container built to be a one-click runnable Hashtopolis agent to use on VastAI"
LABEL org.opencontainers.image.source=https://github.com/ThatOnePasswordWas40Passwords/vast-hashtopolis-runner

# https://catalog.ngc.nvidia.com/orgs/nvidia/containers/cuda
#  - see: "LATEST CUDA XXXX"
FROM nvidia/cuda:12.3.0-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=NONINTERACTIVE

RUN apt update && apt-get upgrade -y && apt install -y --no-install-recommends \
  zip \
  git \
  python3 \
  python3-psutil \
  python3-requests \
  pciutils \
  curl && \
  rm -rf /var/lib/apt/lists/*

CMD mkdir /root/htpclient

WORKDIR /root/htpclient

RUN git clone https://github.com/hashtopolis/agent-python.git && \
  cd agent-python && \
  ./build.sh && \
  mv hashtopolis.zip ../ && \
  cd ../ && rm -R agent-python
