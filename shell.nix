{ pkgs ? import <nixpkgs> {}
}:
let
  python3 = import ./python3.nix { inherit pkgs; };
in pkgs.mkShell {
  buildInputs = [ python3 ];
}
