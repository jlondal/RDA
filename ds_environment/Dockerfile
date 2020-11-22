# Distributed under the terms of GNU General Public License (GPL) 2.0

#########################
#  Base Image creation  #
#########################

FROM jupyter/datascience-notebook

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

# install xgboost. Unfortunately a simple pip install
# will not work and this gets a layer
RUN git clone --recursive https://github.com/dmlc/xgboost && cd xgboost; make -j4 

###############################
#  Environment Customization  #
###############################

RUN pip install --upgrade pip 
RUN pip install --upgrade jupyterlab

RUN pip install --upgrade \
    pandas \
    pyLDAvis \
    ipywidgets \
    ipython-sql \
    psycopg2-binary \
    nbdime \
    yapf \
    autopep8 \
    openpyxl \
    papermill \
    plotly \
    xgboost \
    pyrugga \
    dash \
    jupyterlab_dash \
    ipywidgets \
    jupyter_contrib_nbextensions  \
    bokeh 

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

# Install lab nbextensions

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager \
    && jupyter labextension install @bokeh/jupyter_bokeh

RUN jupyter lab build


RUN jupyter labextension install @j123npm/jupyterlab-dash@0.1.0-alpha.4 \
&& jupyter labextension install @jupyterlab/toc \
&& jupyter labextension install @aquirdturtle/collapsible_headings \
&& jupyter labextension install jupyterlab-dash \
&& jupyter labextension install jupyterlab-drawio

# Create shared folder dropzone and custom profile dir
RUN mkdir /home/$NB_USER/dropzone \
 && mkdir -p /home/$NB_USER/.ipython/profile_default/startup/ \
 && mkdir -p /home/$NB_USER/admin \
 && mkdir -p /home/$NB_USER/datalake 

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
