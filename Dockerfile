# syntax=docker/dockerfile:1.6
# Base: NVIDIA Clara Parabricks NVIDIA Parabricks base image with CUDA and Parabricks tools
FROM nvcr.io/nvidia/clara/clara-parabricks:4.5.1-1

USER root
# Update package repositories
RUN apt-get update -y
RUN apt-get -y install pkg-config
RUN apt-get install libhdf5-dev -y
RUN apt-get -y install sudo

# Install Python 3 pip
RUN apt-get install python3-pip -y
RUN apt install -y git
RUN apt-get install -y wget
RUN python3 -m pip install --upgrade pip
RUN pip install jupyterlab
RUN pip install ipykernel
# (Optional) from here on we *could* switch the default shell to bash,
# but we’ll keep using exec-form RUN for robustness.

# --- Install micromamba (no shell) ---
ENV CONDA_DIR=/opt/conda

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && bash /tmp/miniconda.sh -b -p $CONDA_DIR && rm /tmp/miniconda.sh && $CONDA_DIR/bin/conda clean -afy

# Make conda available globally

ENV PATH=$CONDA_DIR/bin:$PATH

# Verify installation

RUN conda --version && python --version && pip --version

# --- Copy your (already cleaned) env file (no prefix) ---
COPY snakemake-env.yaml /tmp/snakemake-env.yaml

# --- Copy workflow and config directories ---
COPY workflow /opt/snake-test/workflow
COPY config /opt/snake-test/config

# --- Accept conda Terms of Service ---
# RUN conda config --set channel_priority strict
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r
# --- Create the environment (no shell) ---
RUN ["conda","env","create","-f","/tmp/snakemake-env.yaml"]
RUN ["conda","clean","--all","--yes"]

# --- Run everything inside the env; we installed bash, so use it in CMD ---
# ENTRYPOINT ["micromamba","run","-n","snakemake"]
CMD ["conda","run","-n","snakemake","bash","-lc","snakemake --version && sleep infinity"]