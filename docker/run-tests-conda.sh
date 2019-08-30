#!/bin/bash -l

#set -euxo pipefail # Can't use this, 'conda activate' has unbound variables
set -x

pip install pytest-httpserver zstandard
pytest tests integration_tests --odc-config-file odcintegration-docker.conf
