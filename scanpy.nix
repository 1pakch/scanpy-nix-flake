{ buildPythonPackage
, fetchPypi
, hatchling
, hatch-vcs
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
, scikit-misc  # used by `scanpy.pp.highly_variable_genes()`
, leidenalg  # used by `scanpy.tl.leiden()`
}:

buildPythonPackage rec {
  pname = "scanpy";
  version = "1.9.8";
  pyproject = true;

  # TODO check if fetchgit or similar can work (see `anndata.py`)
  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-KrF5DSuC6tsM+NSH9Gi+rHqPajqP1xEtGumJ+MUqQ1M=";
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
    scikit-misc
    leidenalg
  ];

  nativeBuildInputs = [
    hatchling
    hatch-vcs
  ];
}

