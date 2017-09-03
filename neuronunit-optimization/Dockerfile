#author Russell Jarvis rjjarvis@asu.edu
#author Rick Gerkin rgerkin@asu.edu

FROM scidash/neuronunit

#################
# Showcase for model optimization using NeuronUnit.
#################
USER root

RUN apt-get update
RUN apt-get install -y gvfs-bin libxss1 python3-setuptools
RUN apt-get install -y python-tk curl apt-utils
#RUN apt-get install -y povray eog

RUN chown -R jovyan $HOME
RUN chown -R jovyan /opt/conda/lib/python3.5/site-packages/

USER $NB_USER
RUN pip install --upgrade pip
RUN pip install IPython \
                jupyterhub \
                notebook \
                ipykernel \
                ipyparallel \
                enum34
RUN conda install mpi4py
RUN easy_install gevent
RUN easy_install greenlet

##### Scoop #####
WORKDIR $HOME
RUN git clone https://github.com/soravux/scoop
WORKDIR scoop
RUN python setup.py install

##### BluePyOpt ######
WORKDIR $HOME
RUN git clone https://github.com/russelljjarvis/BluePyOpt.git
WORKDIR BluePyOpt
RUN python setup.py install
RUN python -c "import bluepyopt"

##### IPython Cluster #####
USER $NB_USER
WORKDIR $HOME
RUN ipython profile create default
RUN pip install git+https://github.com/roryk/ipython-cluster-helper
# Must be done as root to create directories in /usr/local
RUN sudo /opt/conda/bin/ipcluster nbextension enable

ENV PATH $PATH:/opt/conda/bin
ENV PATH $PATH:/opt/conda/bin/ipcluster
ENV PATH $PATH:/opt/conda/bin/ipython
ENV PATH $PATH:/opt/conda/bin/pip
ENV PATH $PATH:/opt/conda/bin/python
ENV PATH $PATH:/opt/conda/lib/python3.5/site-packages
ENV PATH $PATH:$PYTHONPATH

RUN printenv PATH
RUN python -c "import pyneuroml"
RUN python -c "import neuronunit"
RUN python -c "from neuronunit.models.reduced import ReducedModel"
RUN python -c "import quantities"
RUN python -c "import neuron"
RUN python -c "import pyneuroml"
RUN nrnivmodl
RUN python -c "import scoop"
RUN python -c "import deap"
RUN nrniv

#RUN export PATH=$PATH

#un comment the following line to test ipcluster during build.
#RUN ipcluster start --profile=chase --debug &
#https://github.com/russelljjarvis/neuronunit.git
WORKDIR $WORK_HOME