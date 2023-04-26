{
  description = "A Jupyter notebook environment for single cell analysis";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  };
  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      python3 = import ./python3.nix { inherit pkgs; };
      flakeApp = path: { type = "app"; program = path; };
    in {
      apps.x86_64-linux.default = flakeApp "${python3}/bin/jupyter-notebook";
      apps.x86_64-linux.python3 = flakeApp "${python3}/bin/python3";
      apps.x86_64-linux.ipython = flakeApp "${python3}/bin/ipython";
      packages.x86_64-linux.docker-image = pkgs.dockerTools.buildImage {
        name = "jupyter-scanpy";
        config = { Cmd = [ "${python3}/bin/jupyter-notebook"] ; };
      };
    };
}
