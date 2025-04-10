rule test:
    """
    Rule that creates a test file with some content
    """
    output:
        "test.txt"
    shell:
        """
        echo "Hello, World!" > {output}
        echo "1, 2, 3" >> {output}
        echo "4, 5, 6" >> {output}
        echo "7, 8, 9" >> {output}
        """

rule filter:
    """
    Rule that filters the test file. Only executed if the config["filter"] parameter is set to True.
    """
    input:
        "test.txt"
    output:
        "filtered.txt"
    shell:
        """
        awk -F"," '{{print $1}}' {input} > {output}
        """