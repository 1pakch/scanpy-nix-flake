{ pkgs ? import <nixpkgs> {} }:
with pkgs;
let
  python3 = python310;
  buildPythonPackage = python3.pkgs.buildPythonPackage;
  fetchPypi = python3.pkgs.fetchPypi;

  setuptools-scm = python3.pkgs.setuptools-scm;
  packaging = python3.pkgs.packaging;

  umap-learn = python3.pkgs.umap-learn;
  natsort = python3.pkgs.natsort;
  matplotlib = python3.pkgs.matplotlib;
  seaborn = python3.pkgs.seaborn;
  tqdm = python3.pkgs.tqdm;
  scikit-learn = python3.pkgs.scikit-learn;
  h5py = python3.pkgs.h5py;
  pandas = python3.pkgs.pandas;
  patsy = python3.pkgs.patsy;
  statsmodels = python3.pkgs.statsmodels;
  networkx = python3.pkgs.networkx;
  numba = python3.pkgs.numba;
  joblib = python3.pkgs.joblib;

  pytest = python3.pkgs.pytest;

  anndata = import ./anndata.nix {
    inherit
      buildPythonPackage
      fetchPypi
      setuptools-scm
      packaging
      umap-learn
      natsort
      h5py
      pandas
      pytest;
  };

  stdlib-list = import ./stdlib-list.nix {
    inherit
      buildPythonPackage
      fetchPypi;
  };

  session-info = import ./session-info.nix {
    inherit
      buildPythonPackage
      fetchPypi
      stdlib-list;
  };

  scanpy = import ./scanpy.nix {
    inherit
      buildPythonPackage
      fetchPypi
      setuptools-scm
      packaging
      anndata
      matplotlib
      pandas
      seaborn
      h5py
      tqdm
      scikit-learn
      statsmodels
      patsy
      networkx
      natsort
      joblib
      numba
      umap-learn
      session-info;
  };

in pkgs.mkShell {
  # Add any necessary build-time dependencies here
  buildInputs = [
    (python3.withPackages (ps: [ anndata scanpy ps.jupyter ps.ipython ]))
    # Add other packages here as needed
  ];
}
