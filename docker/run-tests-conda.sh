#!/bin/bash -l

set -euxo pipefile

conda activate odc
pip install pytest-httpserver zstandard
pytest -r a --cov datacube --durations=5 tests integration_tests --odc-config-file odcintegration-docker.conf
