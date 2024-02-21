{ buildPythonPackage
, fetchFromGitHub
}:

buildPythonPackage rec {
  pname = "array-api-compat";
  version = "1.4.1";
  format = "setuptools";

  src = fetchFromGitHub {
    inherit pname version;
    owner = "data-apis";
    repo = pname;
    rev = version;
    sha256 = "iCEJCUUsyxlwpb36DgINniOTzMEiGIuWyQtNBdFDZg8=";
  };

  # tests rely on torch so it's easier to skip
  doCheck = false;
}

