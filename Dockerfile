# syntax=docker/dockerfile:1.6
# Base: NVIDIA Clara Parabricks (NGC) image
FROM nvcr.io/nvidia/clara/clara-parabricks:4.5.1-1

# Ensure we have basic tools and a minimal init (tini)
USER root
RUN apt-get update -y
RUN apt-get -y install pkg-config
RUN apt-get install libhdf5-dev -y
RUN apt-get -y install sudo

# Install Python 3 pip
RUN apt-get install python3-pip -y
RUN apt install -y git

RUN python3 -m pip install --upgrade pip
RUN pip install jupyterlab
RUN pip install ipykernel

COPY ./workflow /opt/snake-test/workflow
COPY ./config /opt/snake-test/config

RUN useradd -s /bin/bash -u 1000 -g 100 -m jovyan && echo "jovyan:users" | chpasswd && adduser jovyan sudo

WORKDIR /home/jovyan
USER jovyan

