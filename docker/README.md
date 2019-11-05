
# Docker Images

Docker images are published on [DockerHub - opendatacube/datacube-core](https://hub.docker.com/r/opendatacube/datacube-core).

Currently, they are built on the base Ubuntu container, dependencies made up of geospatial APT packages 
from a third party NextGIS PPA + Binary Python Wheels. This have served us well, but there are several problems 
we would like to address by building them differently.

- Multiple versions of GDAL and other spatial libraries are installed. Resulting in potential _library version conflicts_ and _image bloat_.
- The images are built in **Docker Cloud** and are not tested before being released.
- The Third Party NextGIS PPA doesn't keep old versions of packages around.
- Build time requirements are included in the Image.


## Alternatives

### Image based on `conda` and `conda-forge`

See [conda-forge/](conda-forge/)

### Image built predominantly from source

See [geobox/](geobase/) and [Kirill888 / geobase](https://github.com/Kirill888/geobase)

### Old **Ubuntu** based Image

See [ubuntu/](ubuntu/)

## Notes

### Integration Test Options

Is it better to use `docker-compose` with **PostgreSQL** running in a separate container?

OR

To use something like [datacube-notebook-bundled-binder](https://github.com/luigidifraia/datacube-notebook-bundled-binder)
which runs a PostgreSQL instance inside the same container. This is pretty easy to install if
using `conda` or an image based on **Ubuntu**?

**Similarly**

When mocking external services like _EC2_ or _SQS_, is it better to run
inside the same process?

OR

Run an extra process inside the same container?

OR

Run an separate container with the mocked server?