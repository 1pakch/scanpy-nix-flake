{ buildPythonPackage
, fetchPypi
, hatchling
, hatch-vcs
, packaging
, umap-learn
, natsort
, h5py
, pandas
, array-api-compat
, pytest
}:
buildPythonPackage rec {
  pname = "anndata";
  version = "0.10.5";
  pyproject = true;

  # TODO: check if the below is still true
  # Note that building with `fetchgit` and `fetchFromGitHub` doesn't work
  # because `setuptools_scm` fails to properly infer the version from the
  # repo checkout made by nix. As a result it looks like running the tests
  # is impossible because they are stripped from the wheel served at pypi.
  src = fetchPypi {
    inherit pname version;
    sha256 = "pV/NdcK0Ra2Ck47NQd4d1Mr2ZUcpDSQjMn4Oifcb9ZA=";
  };

  propagatedBuildInputs = [
    umap-learn
    natsort
    h5py
    pandas
    array-api-compat
    packaging
  ];

  nativeBuildInputs = [
    hatchling
    hatch-vcs
  ];
}
