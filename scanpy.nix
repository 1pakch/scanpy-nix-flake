{ buildPythonPackage
, fetchPypi
, setuptools-scm
, packaging
, anndata
, matplotlib
, pandas
, seaborn
, h5py
, tqdm
, scikit-learn
, statsmodels
, patsy
, networkx
, natsort
, joblib
, numba
, umap-learn
, session-info
}:

buildPythonPackage rec {
  pname = "scanpy";
  version = "1.9.3";
  format = "flit";

  src = fetchPypi {
    inherit pname version;
    sha256 = "3+Zfms2fTBdAB5oJn4n6akS28O917K+FJHrUr4WRRNc=";
  };

  propagatedBuildInputs = [
    # Add any necessary dependencies here
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
    session-info
  ];

  nativeBuildInputs = [
    setuptools-scm
  ];
}

