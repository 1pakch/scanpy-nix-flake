{
  description = "A Jupyter notebook environment for single cell analysis";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  };
  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default = 
      let pkgs = import nixpkgs { system = "x86_64-linux"; };
      in import ./python3.nix { inherit pkgs; };
  };
}
