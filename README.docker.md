# Docker image for Snakemake (Alpine + micromamba)

This Dockerfile builds an Alpine-based image that installs micromamba, creates a conda/mamba environment named `snakemake` containing the latest `snakemake` from `conda-forge`/`bioconda`, and runs `snakemake --cores 1` by default.

Build:

```bash
docker build -t snakemake-micromamba .
```

Run (will execute `snakemake --cores 1` in `/workspace`):

```bash
docker run --rm -v "$(pwd)":/workspace -w /workspace --entrypoint /bin/bash snakemake-micromamba -c "/opt/conda/envs/snakemake/bin/snakemake --cores 1"
```

If you want to pass additional arguments to `snakemake`, append them to `docker run` after the image name.
