# 👷🏽‍♀️Workflow Curation.

## 🗂️The Snakefile.

Snakemake will look for and execute the first rule in the `Snakefile`. By default and convention, `rule all` is the first rule in the `Snakefile`. This rule is used to define the final outputs of the pipeline in the `input` directive. 

For this example pipeline, we shall generate two files, `test.txt` and or `filter.txt` based on the value of the filter option in the [config.yaml](../config/config.yaml) file.

```YAML
filter: True # or False
```

Setting `filter: True` will generate `test.txt` and `filter.txt`, while setting `filter: False` will only generate `test.txt`. 

## 🔣Defining Input Functions

The logic for creating the different pipeline outputs may be handled by a custom function defined in the `common.smk` file in the [rules](./rules/) directory. One can define a function using python syntax. The function returns a list of strings that correspond to the output files.

> NOTE: You may define input functions in your `Snakefile` or in a rule file. In order for you to use a function defined in a another Snakefile you will need to import the Snakefile with.
	`include: "path/to/Snakefile_with_custom_function"`


```python
def get_output(wildcards):
	# Function logic and conditional statements...
	return ["file1.txt", "file2.txt", ...]
```
The input function can be called in the `input` directive of `rule all` in the main pipeline to define all pipeline outputs. Other functions may be defined to manage pipeline rule inputs or outputs.

```python
def inputFunction(wildcards):
    return [... a list of input files to be generated ...]

rule:
    input:
        inputFunction
    output:
        "someoutput.{somewildcard}.txt"
    shell:
        "..."
```
Snakemake wildcards may allow you to define multiple output files, for example multiple samples, that end in the same file extension.


