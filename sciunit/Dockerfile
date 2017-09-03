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
#RUN pip install git+https://github.com/NeuroML/pyNeuroML --process-dependency-links
#RUN pip install git+https://github.com/AllenInstitute/AllenSDK@py34_rgerkin --process-dependency-links

RUN wget http://github.com/scidash/sciunit/tarball/dev -O sciunit.tar.gz
#RUN mkdir -p sciunit
#RUN tar -xvzf sciunit.tar.gz -C sciunit --strip-components=1
#RUN pip install --process-dependency-links -e sciunit.tar.gz

RUN git clone -b dev http://github.com/scidash/sciunit.git

WORKDIR sciunit
RUN ls
RUN python setup.py install
#RUN pip install -e git+http://github.com/scidash/sciunit.git@dev

#RUN /opt/conda/bin/pip setup.py install --process-dependency-links -e

RUN python test_all.py
WORKDIR $HOME/$WORKDIR
