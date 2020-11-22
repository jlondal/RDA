# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

docker rm $(docker ps -q -f 'status=exited')
docker rmi $(docker images -q -f "dangling=true")
docker volume prune;

docker build --no-cache  -t standard_notebook ds_environment/.
docker build -t tensorflow_notebook ds_pymc/.
docker build -t r_notebook ds_r/.

docker build --no-cache -t postgres postgres/.

make build;

