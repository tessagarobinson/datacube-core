#!/usr/bin/env bash

# Expected to run within python:3.x docker container

output_file=$1
input_file=$2

apt-get update
apt-get install -y libgdal-dev

pip install --upgrade pip
pip install pip-tools poetry numpy

pip-compile --output-file $output_file $input_file

