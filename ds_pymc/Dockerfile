# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
#########################
#  Base Image creation  #
#########################

FROM jupyter/tensorflow-notebook

USER root

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

RUN pip install --upgrade pip 

RUN pip install ipywidgets \
    ipython-sql \
    psycopg2-binary \
    pymc3 \
    jupyter_contrib_nbextensions \
    ipywidgets \
    plotly \
    xgboost


RUN jupyter contrib nbextension install --user

# Install nbextensions
RUN jupyter nbextension enable hide_input_all/main \
 && jupyter nbextension enable snippets_menu/main \
 && jupyter nbextension enable codefolding/main \
 && jupyter nbextension enable collapsible_headings/main \
 && jupyter nbextension enable hide_input/main \
 && jupyter nbextension enable code_prettify/code_prettify \
 && jupyter nbextension enable execute_time/ExecuteTime \
 && jupyter nbextension enable table_beautifier/main \
 && jupyter nbextension enable --section=tree tree-filter/index \
 && jupyter nbextension enable --py --sys-prefix widgetsnbextension \
 && jupyter nbextension enable --py widgetsnbextension \
 && jupyter nbextension enable toc2/main


# Create shared folder dropzone and custom profile dir
RUN mkdir /home/$NB_USER/dropzone \
 && mkdir -p /home/$NB_USER/.ipython/profile_default/startup/ \
 && mkdir -p /home/$NB_USER/admin 

###############################################################################
# Aesthetics, branding and default ipython profile
###############################################################################

COPY custom/start.ipy /home/$NB_USER/.ipython/profile_default/startup/start.ipy
COPY custom/ipython_config.py /home/$NB_USER/.ipython/profile_default/ipython_config.py
COPY custom/custom.css /home/$NB_USER/.jupyter/custom/custom.css
COPY admin/ChangeDBPassword.ipynb /home/$NB_USER/admin/ChangeDBPassword.ipynb

# Use custom startup script
# COPY docker-entrypoint.sh /srv/docker-entrypoint.sh
# ENTRYPOINT ["tini", "--", "/srv/docker-entrypoint.sh"]
CMD ["start-singleuser.sh"]
