#!/bin/bash -l

conda activate odc
conda install -y -c conda-forge compliance-checker hypothesis mock pytest pytest-cov pytest-timeout moto celery sharedarray redis-py pathos
pip install pytest-httpserver zstandard
pytest -m "not netcdf and not s3aio" -r a --cov datacube --durations=5 tests integration_tests --odc-config-file odcintegration-docker.conf
