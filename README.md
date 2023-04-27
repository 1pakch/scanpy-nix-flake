# scanpy-nix-flake

[Nix flake](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake.html)
packaging [scanpy](https://github.com/scverse/scanpy) and jupyter notebook server.

## Usage

1. Install [nix](https://nixos.org/download.html) (if not yet installed)
2. Enable nix flakes (if not already)
   ```sh
   mkdir -p ~/.config/nix
   echo -e "experimental-features = nix-command flakes\n" >> ~/.config/nix/nix.conf
   ```
3. Install `git` (if you don't have it alerady installed)
   ```sh
   nix-env -i git
   ```
4. Build this flake and start the jupyter notebook server
   ```sh
   nix run 'github:ilya-kolpakov/scanpy-nix-flake'
   ```

## Docker image

Building:
```sh
nix build .#docker-image
# ./result points to a tar.gz image in nix store
readlink -e ./result
# /nix/store/<HASH>-docker-image-jupyter-scanpy.tar.gz
```

Using:
```sh
zcat jupyter-scanpy-<HASH>.tar.gz | sudo docker load
docker run -p 8888:8888 -v ../path/to/notebooks:/notebooks
```

## Singularity image

First build the docker image, unzip the tar file and run
```sh
singularity build image.sif docker-archive://path/to/image.tar
```
