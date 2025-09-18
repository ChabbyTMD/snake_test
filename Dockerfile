# Use miniconda3 as base
FROM continuumio/miniconda3:latest

LABEL maintainer="auto-generated"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /workspace

# Ensure conda is up to date and install mamba in base for fast environment creation
RUN conda update -n base -c defaults conda -y \
    && conda install -n base -c conda-forge mamba -y \
    && conda clean -afy

# Create the 'snakemake' environment and install snakemake 9.11.2 from conda-forge/bioconda
RUN mamba create -y -n snakemake -c conda-forge -c bioconda snakemake=9.11.2 \
    && conda clean -afy \
    && ln -sf /opt/conda/envs/snakemake/bin/snakemake /usr/local/bin/snakemake

# Copy entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["snakemake", "--cores", "1"]
