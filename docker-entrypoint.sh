#!/usr/bin/env bash
set -euo pipefail

# Try to use conda/mamba run to execute commands inside the 'snakemake' environment.
if command -v mamba >/dev/null 2>&1; then
  exec mamba run -n snakemake -- "$@"
elif command -v conda >/dev/null 2>&1; then
  exec conda run -n snakemake -- "$@"
else
  echo "mamba/conda not found in image" >&2
  exit 1
fi
