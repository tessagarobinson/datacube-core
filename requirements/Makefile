
all: requirements-test.py3.5.txt requirements-test.py3.6.txt 

requirements-test.py%.txt: requirements-test.in requirements.in
	docker run --rm -v $(CURDIR):/tmp/code -w /tmp/code python:$* bash -c "pip install pip-tools poetry; pip-compile --output-file $@ $<"

