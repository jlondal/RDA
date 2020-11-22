# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM postgres:11.5

RUN apt-get update && \
    apt-get install -y \
    cmake \
    pgxnclient \
    postgresql-server-dev-11 \
    postgresql-plpython-11 \
    postgresql-plpython3-11 \
    g++ \
    m4 \
    patch 

RUN apt-get install python-pip -y 
RUN apt-get install python3-pip -y

RUN pip3 install pandas

ENV PGUSER=postgres
ENV PGDATA=/data

COPY postgresql.conf /etc/postgresql
# Override default postgres config file
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
EXPOSE 5432
