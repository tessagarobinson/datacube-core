FROM continuumio/miniconda3


# Get the code, and put it in /code
ENV APPDIR=/tmp/code
RUN mkdir -p $APPDIR
COPY . $APPDIR
WORKDIR $APPDIR


# Set the locale, this is required for some of the Python packages
ENV LC_ALL C.UTF-8

RUN conda config --add channels conda-forge \
    && conda config --set channel_priority strict
RUN conda env create -f requirements/environment.conda-forge.3.6-2.4.yml

SHELL ["/bin/bash", "-cl"]
RUN conda activate odc && pip install .

# Move docs and utils somewhere else, and remove the temp folder
RUN mkdir -p /opt/odc \
    && chmod +rwx /opt/odc \
    && mv $APPDIR/utils /opt/odc/ \
    && mv $APPDIR/docs /opt/odc/ \
    && mv $APPDIR/scripts/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh \
    && rm -rf $APPDIR


# Set up an entrypoint that drops environment variables into the config file
ENTRYPOINT ["docker-entrypoint.sh"]

WORKDIR /opt/odc
CMD ["datacube","--help"]
