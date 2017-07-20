# neuronunit
# author Rick Gerkin rgerkin@asu.edu

FROM scidash/neuron-mpi-neuroml

# This ARG can be replaced with a build-arg containing the hash of the current
# HEAD, which will ensure that if the HEAD has changed (i.e. new commits), 
# then a new tar of the repo will be downloaded.  
ARG HEAD=1
WORKDIR $HOME
RUN git clone -b dev https://github.com/scidash/neuronunit.git
WORKDIR neuronunit
RUN sudo /opt/conda/bin/python setup.py install
WORKDIR $WORK_DIR
# Put the optional local working copy (not the one we just cloned)
# on the working path.  
ENV PYTHONPATH $WORK_HOME/sciunit:$PYTHONPATH
ENV PYTHONPATH $WORK_HOME/neuronunit:$PYTHONPATH

