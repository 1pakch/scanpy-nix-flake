{
  description = "A Jupyter notebook environment for single cell analysis";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  };
  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      pyenv = import ./pyenv.nix { inherit pkgs; };
      flakeApp = path: { type = "app"; program = path; };
    in {
      # apps - available via e.g. `nix run .#python3`
      apps.x86_64-linux.default = self.apps.x86_64-linux.python3;
      apps.x86_64-linux.python3 = flakeApp "${pyenv}/bin/python3";
      # packages - available via e.g. `nix build .#python3`
      packages.x86_64-linux.default = pyenv;
    };
}
