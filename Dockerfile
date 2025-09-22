# syntax=docker/dockerfile:1.6
# Base: NVIDIA Clara Parabricks (NGC) image
FROM nvcr.io/nvidia/clara/clara-parabricks:4.5.1-1

# Ensure we have basic tools and a minimal init (tini)
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl git tini python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install Python tools via pip
RUN python3 -m pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir jupyterlab ipykernel

# Create and switch to a non-root user suitable for shared filesystems
# ARG USERNAME=tideuser
# ARG UID=1000
# ARG GID=1000
# RUN groupadd -g ${GID} ${USERNAME} \
#     && useradd -m -u ${UID} -g ${GID} -s /bin/bash ${USERNAME} \
#     && mkdir -p /workspace \
#     && chown -R ${USERNAME}:${USERNAME} /workspace

# RUN pip install -v --disable-pip-version-check --no-cache-dir --no-build-isolation --global-option="--cpp_ext" --global-option="--cuda_ext" ./
# RUN python3 setup.py install --cuda_ext

WORKDIR /home/jovyan
USER jovyan

# Keep tini as PID 1 for signal handling and child reaping
ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
CMD ["bash"]
