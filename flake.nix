{
  description = "A Jupyter notebook environment for single cell analysis";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };
  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      py-env = import ./py-env.nix { inherit pkgs; };
      r-env = import ./r-env.nix { inherit pkgs; };
      env = pkgs.stdenv.mkDerivation {
        inherit py-env r-env;
        name = "scenv";
        version = "0";
	buildInputs = [ r-env py-env ];
      };
      flakeApp = path: { type = "app"; program = path; };

    in {
      # apps - available via e.g. `nix run .#python3`
      apps.x86_64-linux.default = flakeApp "${env}/bin/jupyter-notebook";
      apps.x86_64-linux.python3 = flakeApp "${env}/bin/python3";
      apps.x86_64-linux.ipython = flakeApp "${env}/bin/ipython";
      # packages - available via e.g. `nix build .#python3`
      packages.x86_64-linux.default = env;
      packages.x86_64-linux.docker-image = pkgs.dockerTools.buildImage {
        name = "jupyter-scanpy";
        extraCommands = "mkdir -p notebooks";  # without leading slash
        config = {
	  Cmd = [
            "${env}/bin/jupyter-notebook"
            "--ip=0.0.0.0"  # listen on all interfaces instead of loopback in the container
            "--allow-root"  # running as root in docker
            "--no-browser"  # do not attempt to launch a browser
            "--notebook-dir=/notebooks"  # top-level notebooks dir from inside the container
          ];
        };
      };
    };
}
