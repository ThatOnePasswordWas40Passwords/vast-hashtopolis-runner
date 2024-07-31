# https://catalog.ngc.nvidia.com/orgs/nvidia/containers/cuda
#  - see: "LATEST CUDA XXXX"
FROM nvidia/cuda:12.5.1-devel-ubuntu22.04

LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.description="Up-to-date CUDA container built to be a one-click runnable Hashtopolis agent to use on Vast.ai."
LABEL org.opencontainers.image.source=https://github.com/ThatOnePasswordWas40Passwords/vast-hashtopolis-runner

ENV DEBIAN_FRONTEND=NONINTERACTIVE

RUN apt update && apt-get upgrade -y && apt install -y --no-install-recommends \
  zip \
  git \
  python3 \
  python3-psutil \
  python3-pip \
  python3-requests \
  pciutils \
  autossh \
  jq \
  curl && \
  rm -rf /var/lib/apt/lists/*


RUN groupadd -g 1001 hashtopolis-user && \
    useradd -g 1001 -u 1001 -m hashtopolis-user -s /bin/bash && \
    echo 'hashtopolis-user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    mkdir -p /home/hashtopolis-user/.ssh && \
    chown -R hashtopolis-user:hashtopolis-user /home/hashtopolis-user/

USER hashtopolis-user
WORKDIR /home/hashtopolis-user

#RUN git clone https://github.com/hashtopolis/agent-python.git && \
#  cd agent-python && \
#  ./build.sh && \
#  mv hashtopolis.zip ../ && \
#  cd ../ && rm -R agent-python
