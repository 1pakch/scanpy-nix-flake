{ pkgs ? import <nixpkgs> {}
}:
with pkgs;
let
  python3 = python310;
  # see https://summer.nixos.org/blog/callpackage-a-tool-for-the-lazy/
  callPackage = lib.callPackageWith (pkgs // python3.pkgs // packages);
  packages = {
    inherit python3;
    anndata = callPackage ./anndata.nix { };
    scanpy = callPackage ./scanpy.nix { };
    session-info = callPackage ./session-info.nix { };
    stdlib-list = callPackage ./stdlib-list.nix { };
  };
in (
  python3.withPackages (
    ps: [
      packages.scanpy
      ps.jupyter
      ps.ipython
    ]
  )
)
