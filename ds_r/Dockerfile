# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

#########################
#  Base Image creation  #
#########################

FROM jupyter/r-notebook

USER root

RUN conda update --all --yes
COPY packages.R /home/packages.R
RUN cd /home \
&& Rscript  /home/packages.R

RUN conda config --set ssl_verify False

# install some usefull terminal utils
RUN apt-get update --fix-missing -y \
 && apt-get install -y \
 zip \
 pandoc \
 vim \
 tmux \
 fonts-dejavu 

USER $NB_USER

###############################
#  Environment Customization  #
###############################

# Create shared folder dropzone and custom profile dir
RUN mkdir /home/$NB_USER/dropzone 

###############################################################################
# Aesthetics, branding and default ipython profile
###############################################################################

COPY custom/custom.css /home/$NB_USER/.jupyter/custom/custom.css

# Use custom startup script
# COPY docker-entrypoint.sh /srv/docker-entrypoint.sh
# ENTRYPOINT ["tini", "--", "/srv/docker-entrypoint.sh"]
CMD ["start-singleuser.sh"]
