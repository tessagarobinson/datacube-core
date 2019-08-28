# if vars not set specifially: try default to environment, else fixed value.
# strip to ensure spaces are removed in future editorial mistakes.
# tested to work consistently on popular Linux flavors and Mac.
ifeq ($(user),)
# USER retrieved from env, UID from shell.
HOST_USER ?= $(strip $(if $(USER),$(USER),nodummy))
HOST_UID ?= $(strip $(if $(shell id -u),$(shell id -u),4000))
HOST_GID ?= $(strip $(if $(shell id -g),$(shell id -u),4000))
else
# allow override by adding user= and/ or uid=  (lowercase!).
# uid= defaults to 0 if user= set (i.e. root).
HOST_USER = $(user)
HOST_UID = $(strip $(if $(uid),$(uid),0))
endif


# export such that its passed to shell functions for Docker to pick up.
export HOST_USER
export HOST_UID

all: requirements-test.py3.5.txt requirements-test.py3.6.txt

requirements-test.py%.txt: requirements-test.in requirements.in
	docker run --rm -v $(CURDIR):/tmp/code -w /tmp/code python:$* ./update-requirements.sh $@ $<

.PYHONY: conda-deps

conda-deps: environment.defaults.yml environment.cf.yml

CONDA_ENV_NAME = odc

pyversions := 3.6 3.7
gdalversions := 2.4 3

combo := $(foreach pyv,$(pyversions),$(foreach gdalv,$(gdalversions),$(pyv)-$(gdalv)))

#all: environment.conda-forge.$(combo).yml
all: $(foreach c,$(combo),environment.conda-forge.$(c).yml)

$(combo):
	docker build -t opendatacube/datacube-core:conda-forge-$@ -f docker/conda-forge/Dockerfile .

environment.conda-forge.%.yml: conda-forge.in
	cp $< $<.$*
	$(eval PYV=$(firstword $(subst -, ,$*)))
	$(eval GDALV=$(lastword $(subst -, ,$*)))
	echo python=$(PYV)\* >> $<.$*
	echo gdal=$(GDALV)\* >> $<.$*

	docker run --rm -v $(CURDIR):/tmp/code -w /tmp/code continuumio/miniconda3 /bin/bash -lc "\
		conda create -c conda-forge -n $(CONDA_ENV_NAME) --file $<.$* && \
		conda env export -n $(CONDA_ENV_NAME) > $@.tmp && \
		chown $(HOST_UID):$(HOST_GID) $@.tmp"
	mv $@.tmp $@


environment.defaults.yml: conda-defaults.in
	docker run --rm -v $(CURDIR):/tmp/code -w /tmp/code continuumio/miniconda3 /bin/bash -lc "\
		conda create -n $(CONDA_ENV_NAME) --file $<; \
		conda activate $(CONDA_ENV_NAME); \
		pip install pypeg2 lark-parser cachetools; \
		conda env export -n $(CONDA_ENV_NAME) > $@; \
		chown $(HOST_UID):$(HOST_GID) $@"


conda-shell:
	docker run --rm -it -v $(CURDIR):/tmp/code -w /tmp/code continuumio/miniconda3 /bin/bash
