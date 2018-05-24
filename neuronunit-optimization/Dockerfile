# author Russell Jarvis rjjarvis@asu.edu
# author Rick Gerkin rgerkin@asu.edu
# neuronunit-showcase

FROM scidash/neuronunit

#################
# Showcase for model optimization using NeuronUnit.
#################
USER root




RUN apt-get update
RUN apt-get install -y gvfs-bin libxss1 python3-setuptools
RUN apt-get install -y python-tk curl apt-utils


#RUN sudo chown -R jovyan $HOME
#RUN sudo chown -R jovyan /opt/conda/lib/python3.5/site-packages/

USER $NB_USER
RUN pip install --upgrade pip
RUN pip install -U matplotlib
RUN pip install IPython \
                jupyterhub \
                notebook \
                ipykernel \
                enum34 \
		numba

#numba is for optimized code, bqplot is for interactive plotting.
RUN conda install mpi4py


RUN easy_install gevent
RUN easy_install greenlet

ENV PATH $PATH:/opt/conda/bin
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
RUN nrniv
WORKDIR $HOME
ENV PYTHONPATH $HOME/neuronunit:$PYTHONPATH

