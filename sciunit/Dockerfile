# sciunit
# author Rick Gerkin rgerkin@asu.edu
FROM scidash/scipy-notebook-plus

WORKDIR /home/mnt
USER root
RUN chown -R $NB_USER . 
USER $NB_USER

# This ARG can be replaced with a build-arg containing the hash of the current
# HEAD, which will ensure that if the HEAD has changed (i.e. new commits), 
# then a new tar of the repo will be downloaded.  
ARG HEAD=1
RUN wget http://github.com/scidash/sciunit/tarball/dev -O sciunit.tar.gz
RUN mkdir -p sciunit
RUN tar -xvzf sciunit.tar.gz -C sciunit --strip-components=1
WORKDIR sciunit
RUN python setup.py install
WORKDIR $HOME/$WORKDIR