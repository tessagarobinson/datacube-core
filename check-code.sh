#!/usr/bin/env bash
# Convenience script for running Travis-like checks.

set -eu
set -x

pycodestyle tests integration_tests examples utils --max-line-length 120

pylint -j 2 --reports no datacube datacube_apps


set +x

# Optinally validate example yaml docs.
if which yamllint;
then
    set -x
    yamllint $(find . -path requirements -prune -o \( -iname '*.yaml' -o -iname '*.yml' \))
    set +x
fi
