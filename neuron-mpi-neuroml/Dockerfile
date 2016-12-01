#author Russell Jarvis rjjarvis@asu.edu
#author Rick Gerkin rgerkin@asu.edu

FROM scidash/scipy-notebook-plus

WORKDIR $HOME
RUN wget https://www.open-mpi.org/software/ompi/v2.0/downloads/openmpi-2.0.0.tar.gz
RUN tar -xzf openmpi-2.0.0.tar.gz && rm openmpi-2.0.0.tar.gz
WORKDIR $HOME/openmpi-2.0.0

# Compile openmpi
RUN ./configure
RUN make all
RUN sudo make install

# Get python bindings for open mpi
WORKDIR $HOME
RUN conda install -y mpi4py ipython

# Install NEURON-7.4 with python, with MPI
# An infamous build process,and much of the motivation for this container
RUN wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.4/nrn-7.4.tar.gz
RUN tar -xzf nrn-7.4.tar.gz && rm nrn-7.4.tar.gz 
WORKDIR $HOME/nrn-7.4
RUN ./configure --prefix=`pwd` --without-iv --with-nrnpython=/opt/conda/bin/python --with-paranrn=/usr/bin/mpiexec
RUN make all
RUN sudo make install

# Create python bindings for NEURON
WORKDIR src/nrnpython
RUN python setup.py install
ENV NEURON_HOME $HOME/nrn-7.4/x86_64
ENV PATH $NEURON_HOME/bin:$PATH
WORKDIR $HOME

# Get JNeuroML
#Change to this when PR is accepted
#RUN git clone https://github.com/NeuroML/jNeuroML
RUN git clone https://github.com/russelljjarvis/jNeuroML.git
WORKDIR jNeuroML
RUN python getNeuroML.py
