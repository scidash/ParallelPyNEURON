
# NEURON Dockerfile
#


# Set the base image to Ubuntu

FROM ubuntu

# author russell jarvis rjjarvis@asu.edu


USER root

RUN \
  apt-get update && \
  apt-get install -y libncurses-dev openmpi-bin openmpi-doc libopenmpi-dev && \
  apt-get install -y python-setuptools python-dev build-essential

RUN \
   apt-get install -y python-pip && \
   apt-get install -y wget



# Fetch openmpi source files, extract them, delete .tar.gz file.

RUN \
   wget https://www.open-mpi.org/software/ompi/v2.0/downloads/openmpi-2.0.0.tar.gz && \
   tar -xzf openmpi-2.0.0.tar.gz && \
   rm openmpi-2.0.0.tar.gz

WORKDIR openmpi-2.0.0

# Compile openmpi
RUN \
  ./configure && \
  make all && \
  make install

WORKDIR $HOME/neuron

# Fetch NEURON source files, extract them, delete .tar.gz file.
RUN \
  wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.4/nrn-7.4.tar.gz && \
  tar -xzf nrn-7.4.tar.gz && \
  rm nrn-7.4.tar.gz 

WORKDIR nrn-7.4
RUN ./configure --prefix=`pwd` --without-iv --with-nrnpython=/usr/bin/python --with-paranrn=/usr/bin/mpiexecxs
RUN make all && \
make install


# Install python interface
WORKDIR src/nrnpython
RUN python setup.py install

WORKDIR $HOME/dev

RUN apt-get -y install git


WORKDIR $HOME/dev
RUN git clone https://github.com/russelljjarvis/nrnenv
# WORKDIR nrnenv
# RUN cp nrnenv $HOME
# echo “source nrnenv” >> ~/.bashrc
# RUN create_user_in_docker.sh

RUN apt-get -y install xterm



# WORKDIR $HOME/dev/mpi4py

# RUN ls *.py
# RUN python setup.py install
# RUN python setup.py build --mpicc=/usr/bin/mpicc

RUN pip install mpi4py

WORKDIR $HOME/dev
RUN git clone https://github.com/hglabska/Thalamocortical_imem
WORKDIR Thalamocortical_imem
# RUN python setup.py install

WORKDIR $HOME/dev
RUN git clone https://github.com/espenhgn/LFPy
# WORKDIR LFPy

# RUN python setup.py install
WORKDIR $HOME/dev

RUN apt-get -y install default-jre
RUN apt-get -y install default-jdk
RUN wget http://apache.mesi.com.ar/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
# RUN tar -xzf apache-maven-3.3.9-bin.tar.gz && \
# RUN rm apache-maven-3.3.9-bin.tar.bz
# WORKDIR apache-maven-3.3.9-bin

# PATH=/apache-maven-3.3.9-bin

RUN \
  pip install ipython

RUN \
  apt-get -y install vim emacs python3-mpi4py

RUN \
  git clone https://github.com/mpi4py/mpi4py.git


WORKDIR $HOME/dev
RUN git clone git://github.com/NeuroML/jNeuroML.git neuroml_dev/jNeuroML
WORKDIR neuroml_dev/jNeuroML
# python getNeuroML.py # development

# WORKDIR mpi4py


RUN git clone https://github.com/rgerkin/rickpy

