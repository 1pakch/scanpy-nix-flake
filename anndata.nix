{ buildPythonPackage
, fetchPypi
, setuptools-scm
, packaging
, umap-learn
, natsort
, h5py
, pandas
, pytest
}:
buildPythonPackage rec {
  pname = "anndata";
  version = "0.9.1";
  format = "flit";

  # Note that building with `fetchgit` and `fetchFromGitHub` doesn't work
  # because `setuptools_scm` fails to properly infer the version from the
  # repo checkout made by nix. As a result it looks like running the tests
  # is impossible because they are stripped from the wheel served at pypi.
  src = fetchPypi {
    inherit pname version;
    sha256 = "HyjyxCfmewuZvdKygXF8kqEmYN/SPgaUk5tucz8OssQ=";
  };

  propagatedBuildInputs = [
    umap-learn
    natsort
    h5py
    pandas
    packaging
  ];

  nativeBuildInputs = [
    setuptools-scm
  ];
}
