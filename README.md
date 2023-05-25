# numbat_singularity

This is a crude singularity image providing a jupyter notebook with an interface to R and Python. The main usage of that is to document your numbat analysis.

# Install

You of cause neeed singularity (https://docs.sylabs.io/guides/latest/user-guide/)[https://docs.sylabs.io/guides/latest/user-guide/].

Clone this repo cd into the folder and use make to restart the build process.

```
make restart
```

This will create a sandbox folder that can then be used to e.g. add or update the software using the shell.sh script:

```
<path to this repo>/shell.sh
```

This will shell into the image from anywhere on your computer.

Once you are OK with the functionality of the image you can use ``make build`` to build the image.

Once the image is build you can use ``run.sh`` to start the container's jupyter notebook.
This script once again works from any place on your computer.

I hope this does help.




