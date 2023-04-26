# Docker image

Building:
```
nix build .#docker-image
# ./result points to a tar.gz image in nix store
readlink -e ./result
# /nix/store/<HASH>-docker-image-jupyter-scanpy.tar.gz
```

Using:
```
zcat jupyter-scanpy-<HASH>.tar.gz | sudo docker load
docker run -p 8888:8888 -v ../path/to/notebooks:/notebooks
```


