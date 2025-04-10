# 🐍 Snakemake Tutorial

This is a very brief introduction to get you a starting point building your own Snakemake pipelines. The Snakemake documentation is very thorough and detailed, feel free to check it out [here](https://snakemake-wrappers.readthedocs.io/en/stable/).

## ⚙️ Installation

### 📚Prerequisties 

* Latest stable mamba and/or miniconda 
* Python >= 3.10

### 🐍Installation through Conda
The command below will download and install the latest stable version of snakemake from the bioconda channel into a new environment called `snakemake`
```bash
conda create -n snakemake -c bioconda snakemake
```

### 🐉Installation through Mamba
If you have configured your system to use mamba, you can create a similar envrivornment with;

```bash
mamba create -n snakemake -c bioconda snakemake
```

> This tutorial will be referencing conda commands. Subtitute all occurences of conda with mamba to achieve the same outcome.


## 🧱Suggested Workflow Structure

```bash
├── data/               # Raw and processed input data
├── results/            # Outputs such as plots, reports
├── workflow/           # Snakemake rules
	├── rules/
├── envs/               # Conda environment YAML files
├── config/             # Config.yaml and sample sheet
├── scripts/            # Custom Python/R scripts
└── README.md           # Project overview

```
Depending on your needs, your directory structure can be modified to suit your specific project. Place your main Snakefile in the `workflow` directory. The `Snakefile` is the main entry point for Snakemake and may contain all the rules that define how to process your data. To learn more on curating your pipeline structure refer to the guide [here](workflow/README.md).

## 🧑🏽‍💻Execution

### 🌵Perform a dry run

Dry runs simulate your pipelines workflow without executing any of the commands you have specified in your rules. This is a great way to check for errors in your pipeline before executing it. If your dry runs are successful you will be presented with a table containing a list of the number of jobs to be executed.

A dry run can be ran with the following syntax specifying the `-n` flag;
```bash
conda activate snakemake
snakemake -n --cores {number_of_cores} --use-conda
```
Optionally you could use the `-np` flag to view the shell commands to be executed per job;
```bash
snakemake -np --cores {number_of_cores} --use-conda
```
### 🪈Execute pipeline
```bash
snakemake --cores {number_of_cores} --use-conda
```

>NOTE: The above method works when the `Snakefile` is in your current working directory.

If your main snakefile is contained in the `workflow` directory, execute your pipeline with;
```bash
snakemake --cores {number_of_cores} --snakefile workflow/Snakefile --use-conda
```


## 🔎Pipeline Visualization.
One can visualize the pipelines' execution flow, known as a directed acyclic graph of jobs(DAG) with the `dot` tool in the graphviz package. In the example below we shall generate a `.png` image, however the following formats are supported;
* JPEG `-Tjpg` or `-Tjpeg`
* PDF `-Tpdf`
* SVG (Structured Vector Graphics) `-Tsvg`

dot supports a variety of other formats, feel free to check out their documentation [here](https://graphviz.org/pdf/dot.1.pdf)

```bash
snakemake --cores 1 --use-conda --dag | dot -Tpng > pipeline_dag.png
```
