#!/bin/bash -l

#set -euxo pipefail # Can't use this, 'conda activate' has unbound variables
set -x

conda activate odc
pip install pytest-httpserver zstandard
pytest -r a --cov datacube --durations=5 tests integration_tests --odc-config-file odcintegration-docker.conf
