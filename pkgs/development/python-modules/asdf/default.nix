{ lib
, asdf-standard
, asdf-transform-schemas
, astropy
, buildPythonPackage
, fetchPypi
, importlib-resources
, jmespath
, jsonschema
, lz4
, numpy
, packaging
, pytest-astropy
, pytestCheckHook
, pythonOlder
, pyyaml
, semantic-version
, setuptools-scm
}:

buildPythonPackage rec {
  pname = "asdf";
  version = "2.11.0";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-FEWXGSkneduhO9+YlzrZvpJHUsI7TeagVLwBdMEIRvw=";
  };

  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    asdf-standard
    asdf-transform-schemas
    jmespath
    jsonschema
    numpy
    packaging
    pyyaml
    semantic-version
  ] ++ lib.optionals (pythonOlder "3.9") [
    importlib-resources
  ];

  checkInputs = [
    astropy
    lz4
    pytest-astropy
    pytestCheckHook
  ];

  preCheck = ''
    export PY_IGNORE_IMPORTMISMATCH=1
  '';

  pythonImportsCheck = [
    "asdf"
  ];

  meta = with lib; {
    description = "Python tools to handle ASDF files";
    homepage = "https://github.com/asdf-format/asdf";
    license = licenses.bsd3;
    maintainers = with maintainers; [ costrouc ];
  };
}
