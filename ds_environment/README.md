
# Default

This is based on the `datascience-notebook` image of the
[jupyter docker-stacks](https://github.com/jupyter/docker-stacks). The Docker file should you want to modify anything can be found in ds_environment. 

By default, this image has support for three popular languages for data science:

* Python
* R
* Julia

There is a provision for installation of additional `R` packages in the
Dockerfile but this is commented out by default. Julia comes as is.

There are a few useful packages install in addition to the vanilla image. Most notable of which is the addition of tensorflow which in jupyter docker-stacks comes only as a separate image.

In addition to the python packages this image controls the aesthetics of the
notebooks as well as any default library loading. These are spread across
three files:

* `start.ipy`
* `ipython_config.py`
* `custom.css`

The Dockerfile executes instructions and places each file in the appropriate location of the home directory of the notebook user ($NB_USER).

### start.ipy

This file contains all the imports and its path in the image:

`/home/$NB_USER/.ipython/profile_default/startup/start.ipy`

The color palette is also specified here.

### ipython_config.py

This files controls various parameters and can specify commands to be
executed upon opening a notebook. The file `start.ipy` is also specified to be
loaded in this file.

The location in the image is:

`/home/$NB_USER/.ipython/profile_default/ipython_config.py`

It also allows loading default external ipython magic scripts like `autoreload`
and `ipython-sql`.

### custom.css

This file controls the aesthetics of the notebook like its width and the color
of the headers. Its location in the image is:

`/home/$NB_USER/.jupyter/custom/custom.css`