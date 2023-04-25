{ buildPythonPackage
, fetchPypi
, stdlib-list
}:
buildPythonPackage rec {
  pname = "session_info";
  version = "1.0.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "PNpeA8ynA/Mq4urb1r2AtsIUQs+2DkEsIcuK1tXLtrc=";
  };

  propagatedBuildInputs = [
    # Add any necessary dependencies here
    stdlib-list
  ];
}
