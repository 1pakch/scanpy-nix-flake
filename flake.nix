{
  description = "A Jupyter notebook environment for single cell analysis";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  };
  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      python3 = import ./python3.nix { inherit pkgs; };
    in {
      #packages.x86_64-linux.default = python3;
      apps.x86_64-linux.default = { type = "app"; program = "${python3}/bin/jupyter-notebook"; };
      apps.x86_64-linux.python3 = { type = "app"; program = "${python3}/bin/python3"; };
      apps.x86_64-linux.ipython = { type = "app"; program = "${python3}/bin/ipython"; };
    };
}
