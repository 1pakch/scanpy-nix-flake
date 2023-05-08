{ python3
, buildPythonPackage
, fetchPypi
, setuptools_scm
, git
, pkg-config
, igraph
, cmake
, python-igraph
, ddt
}:
buildPythonPackage rec {
  pname = "leidenalg";
  version = "0.9.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-flz+O2+A8yuQ9V81xo1KmQsEibEoLPP6usjNpJiJdfM=";
  };

  nativeBuildInputs = [
    setuptools_scm
    git
    pkg-config
  ];

  propagatedBuildInputs = [
    python-igraph
  ];

  buildInputs = [
    igraph
    ddt
  ];

  # We are instructing to use the external igraph C library brought in via nix. 
  setupPyGlobalFlags = [ "--external" "--use-pkg-config" ];
  
  # The setup.py will attempt to build the copy of igraph library included in
  # the repo (as a submodule) regardless of the settings above. Removing the
  # sources prevents this from happening.
  postPatch = "rm -r vendor";
}
