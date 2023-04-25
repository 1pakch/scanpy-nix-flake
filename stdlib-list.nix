{ buildPythonPackage
, fetchPypi
}:
buildPythonPackage rec {
  pname = "stdlib-list";
  version = "0.8.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "oeUDcZcg1x4u1w7YCbOFxgzT+1Vbp+wEa5Y2DTCxbZ8=";
  };

  # tests fail on python >= 3.10 see https://github.com/jackmaney/python-stdlib-list/pull/49
  doCheck = false;
}
