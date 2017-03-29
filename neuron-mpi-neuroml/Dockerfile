
#FROM scidash/scipy-notebook-plus
FROM neuralensemble/base
MAINTAINER andrew.davison@unic.cnrs-gif.fr
ENV NEST_VER=2.12.0 NRN_VER=7.4

USER root

WORKDIR $HOME


# Get python bindings for open mpi

RUN apt-get update; apt-get install -y automake libtool build-essential openmpi-bin libopenmpi-dev git vim  \
                       wget python3 libpython3-dev libncurses5-dev libreadline-dev libgsl0-dev cython3 \
                       python3-pip python3-numpy python3-scipy python3-matplotlib python3-jinja2 python3-mock \
                       ipython3 python3-httplib2 python3-docutils python3-yaml \
                       python3-venv python3-mpi4py python3-tables cmake



# Install NEURON-7.4 with python, with MPI
# An infamous build process,and much of the motivation for this container
RUN wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.4/nrn-7.4.tar.gz
RUN tar -xzf nrn-7.4.tar.gz && rm nrn-7.4.tar.gz
WORKDIR $HOME/nrn-7.4
RUN ./configure --prefix=`pwd` --without-iv --with-nrnpython=/opt/conda/bin/python --with-paranrn
RUN make all
#RUN conda install 2to3
RUN make install

# Create python bindings for NEURON
WORKDIR src/nrnpython
RUN python setup.py install
ENV NEURON_HOME $HOME/nrn-7.4/x86_64
ENV PATH $NEURON_HOME/bin:$PATH
WORKDIR $HOME


#RUN /usr/bin/mpiexec -np 4 nrniv -mpi $HOME/neuron/nrn-7.4/src/parallel/test0.hoc
#RUN /usr/bin/mpiexec -np 4 nrniv -mpi=/usr/bin/mpiexec $HOME/neuron/nrn-7.4/src/parallel/test0.hoc

# Get JNeuroML
#Change to this when PR is accepted
RUN git clone https://github.com/NeuroML/jNeuroML
RUN git clone https://github.com/russelljjarvis/jNeuroML.git
WORKDIR jNeuroML
RUN python getNeuroML.py
