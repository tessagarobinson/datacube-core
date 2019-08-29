
.PHONY: docker clean shell test-install

pyversions := 3.6 3.7
gdalversions := 2.4 3

combo := $(foreach pyv,$(pyversions),$(foreach gdalv,$(gdalversions),$(pyv)-$(gdalv)))



docker:
	docker build -t opendatacube/datacube-core:conda-forge -f docker/conda-forge/Dockerfile .


clean:
	find . -name __pycache__ | xargs rm -rf
	rm -rf .hypothesis

test:
	ODC_TAG=conda-forge docker-compose -f docker/docker-compose-test.yml run --rm odc

shell:
	docker run -it -w /tmp/code -v $(CURDIR):/tmp/code --rm opendatacube/datacube-core:conda-forge bash


test-install:
	pip install '.[test,celery,s3]'
	pip install ./tests/drivers/fail_drivers --no-deps --upgrade
