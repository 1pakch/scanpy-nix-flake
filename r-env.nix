{ pkgs ? import <nixpkgs> {}
}:
with pkgs;
rWrapper.override {
  packages = with rPackages; [ ggplot2 SoupX scDblFinder ];
}
