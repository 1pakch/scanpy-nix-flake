{
  description = "A Jupyter notebook environment for single cell analysis";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };
  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      python3 = import ./python3.nix { inherit pkgs; };
      flakeApp = path: { type = "app"; program = path; };
    in {
      # apps - available via e.g. `nix run .#python3`
      apps.x86_64-linux.default = flakeApp "${python3}/bin/jupyter-notebook";
      apps.x86_64-linux.python3 = flakeApp "${python3}/bin/python3";
      apps.x86_64-linux.ipython = flakeApp "${python3}/bin/ipython";
      # packages - available via e.g. `nix build .#python3`
      packages.x86_64-linux.default = python3;
      packages.x86_64-linux.docker-image = pkgs.dockerTools.buildImage {
        name = "jupyter-scanpy";
        extraCommands = "mkdir -p notebooks";  # without leading slash
        config = {
	  Cmd = [
            "${python3}/bin/jupyter-notebook"
            "--ip=0.0.0.0"  # listen on all interfaces instead of loopback in the container
            "--allow-root"  # running as root in docker
            "--no-browser"  # do not attempt to launch a browser
            "--notebook-dir=/notebooks"  # top-level notebooks dir from inside the container
          ];
        };
      };
    };
}
