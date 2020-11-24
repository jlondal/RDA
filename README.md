# Rugby Data Environment

This environment fills the gap between direct installation via [The Littlest Jupyterhub](https://tljh.jupyter.org/en/latest/) and managing thousands of users via [JupyterHub with Kubernetes](https://zero-to-jupyterhub.readthedocs.io/en/latest/). If you have a team of 10 - 15 folks in your organisation and want to quickly stand up a Jupyterhub + Postgres with MADLIB and PL/Python database you are in the correct place.

But why the Rugby name? Well this environment comes pre installed with [PyRugga](https://github.com/jlondal/pyrugga) a library to help analyse Opta super scout files. That was the motifation behind this project. I wanted Juypter setup on my home NAS to analyse rugby matches. You can do more with it!

## Quick Start

Before you begin you will need to generate a SSL certificate. Place your .key and .crt into secrets folder. You can either use a self signed [cert](https://medium.com/better-programming/how-to-create-ssl-certificates-for-development-861237235933) or get a free cert from [SSL for free](https://www.sslforfree.com/). Files need to be named 'jupyterhub.crt' and 'juypterhub.key'. In production I would recommend running the environment behind [NGNIX](https://medium.com/@mightywomble/how-to-set-up-nginx-reverse-proxy-with-lets-encrypt-8ef3fd6b79e5). 

For the lazy I have provide SSL certs that are not valid. You will get a warning in your browser but you can ignore it and everything should still work. 

Finally there is a file called userlist. This file file contains a list of users you would like to have setup at the start. I would recommend just having one admin user and then creating new users from the admin account. Note the first time you login as admin you will be asked to create a password. The default user is master_user

The environment can be built by running the `build.sh` script:

```bash
cp env.txt .env
bash build.sh
docker-compose up
```

You can access your environment via [JupyterHub](https://127.0.0.1:8000).To take the environment down type

```bash
docker-compose down
```

## Database Setup

There is no password for Postgres as default so we would recommend changing these connection details and configuring Postgres to your needs. The details of how this can be done can be found in the Postgres section 

```python
Port = 5432
Host = 127.0.0.1
Username = postgres
Password = 
```

You can access Postgres via any SQL query browsers but we use pgAdmin 4.

Additional MADLIB and PL/Python can be installed as below 

```bash
sudo docker exec -it "madlib_postgres" bash

psql -d postgres -c "CREATE EXTENSION plpythonu;"
psql -d postgres -c "CREATE EXTENSION plpython3u;"

MAKEFLAGS='-j1' pgxn install madlib \
    && pgxn load madlib

/usr/local/madlib/bin/madpack -s madlib -p postgres -c postgres@localhost:5432/postgres install
/usr/local/madlib/bin/madpack -s madlib -p postgres -c postgres@localhost:5432/postgres install-check
```

after this you will need to add users. Read this [tutorial](https://medium.com/coding-blocks/creating-user-database-and-adding-access-on-postgresql-8bfcd2f4a91e)

## Modifying your environment?

* Docker-compose.yml contains the details of ports your environment is running on along with some environment variables

* Perhaps the most important file of the configuration is `jupyter_config.py`. This file controls key aspects of the environment such as which user management system to use and what notebook servers can be started. 

* A key file that is currently not provided as part of the repo is a file named `.env` which holds important variables utilized across the building process. An example of how to setup this file is in the env.txt 

* There are three notebook services packaged with the environment. They can be found in the the folders begining with ds_. There are Docker files in each which can be modfied to your tasts along with README files for instruction on how to do so.

    * Default (this will load the first time you login )
    * TensorFlow (PyMC3)
    * R

* Finally there is a Progres database this is located in the postgres folder. Some setup after you have stood up your environment for the first time will be required.

## License 

Modified BSD License