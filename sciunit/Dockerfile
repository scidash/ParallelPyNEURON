
FROM scidash/scipy-notebook-plus

# This ARG can be replaced with a build-arg containing the hash of the current
# HEAD, which will ensure that if the HEAD has changed (i.e. new commits),
# then a new tar of the repo will be downloaded.
ARG HEAD=1
WORKDIR $HOME
RUN wget http://github.com/scidash/sciunit/tarball/dev -O sciunit.tar.gz
RUN mkdir -p sciunit
RUN tar -xvzf sciunit.tar.gz -C sciunit --strip-components=1
RUN rm sciunit.tar.gz
WORKDIR sciunit
RUN pip install --process-dependency-links -e .
WORKDIR $WORK_HOME
