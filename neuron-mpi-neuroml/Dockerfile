#author russell jarvis rjjarvis@asu.edu

FROM scipy-notebook-plus
USER root

WORKDIR $HOME

RUN \
   wget https://www.open-mpi.org/software/ompi/v2.0/downloads/openmpi-2.0.0.tar.gz && \
   tar -xzf openmpi-2.0.0.tar.gz && \
   rm openmpi-2.0.0.tar.gz

WORKDIR $HOME/openmpi-2.0.0

# Compile openmpi
RUN ./configure
RUN make all && \
    make install

# Get python bindings for open mpi
WORKDIR $HOME
RUN conda install -y mpi4py ipython

#Install NEURON-7.4 with python, with MPI. An infamous build process,
#and much of the motivation for this docker container
WORKDIR $HOME/neuron
# Fetch NEURON source files, extract them, delete .tar.gz file.
RUN \
  wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.4/nrn-7.4.tar.gz && \
  tar -xzf nrn-7.4.tar.gz && \
  rm nrn-7.4.tar.gz 

WORKDIR $HOME/neuron/nrn-7.4
RUN ./configure --prefix=`pwd` --without-iv --with-nrnpython=/opt/conda/bin/python --with-paranrn=/usr/bin/mpiexec
RUN make all && \
    make install

#Create python bindings for NEURON
WORKDIR src/nrnpython
RUN python setup.py install
ENV PATH $HOME/neuron/nrn-7.4/x86_64/bin:$PATH

#Get JNeuroML
RUN echo $PATH
WORKDIR $HOME/git
#TODO change back to this repository, once pull request as accepted for python3 compliant code
#RUN sudo git clone https://github.com/NeuroML/jNeuroML
RUN git clone https://github.com/russelljjarvis/jNeuroML.git
WORKDIR jNeuroML
RUN python getNeuroML.py

USER $NB_USER