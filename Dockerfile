#
# NEURON Dockerfile
#


# Set the base image to Ubuntu

FROM ubuntu

# and russell jarvis rjjarvis@asu.edu


USER root

RUN \
  apt-get update && \
  apt-get install -y libncurses-dev openmpi-bin openmpi-doc libopenmpi-dev && \
  apt-get install -y python-setuptools python-dev build-essential

# apt-get easy_install
# RUN \
#    wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
# RUN \
#    bash Miniconda2-latest-Linux-x86_64.sh
# RUN \
#   git clone https://github.com/mpi4py/mpi4py
# RUN \
#   cd mpi4py
# RUN \
#   sudo python setup.py install
# RUN \
#   cd ../
# Make ~/neuron directory to hold stuff.

# RUN \
#   easy_install pip
RUN \
   apt-get install -y python-pip && \
   apt-get install -y wget


   
WORKDIR neuron

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

WORKDIR $HOME
# Fetch NEURON source files, extract them, delete .tar.gz file.
RUN \
  wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.4/nrn-7.4.tar.gz && \
  tar -xzf nrn-7.4.tar.gz && \
  rm nrn-7.4.tar.gz && \
  make all && \
  make install


WORKDIR nrn-7.4

# Compile NEURON.
#RUN \
#  ./configure --prefix=`pwd` --without-iv --with-nrnpython=/usr/bin/python --with-paranrn=/usr/
# bin/mpiexec

RUN \
  apt-get -y install python3

RUN \
  ./configure --prefix=`pwd` --without-iv --with-nrnpython=/usr/bin/python --with-paranrn=/usr/bin/mpiexec

RUN \
  make all
RUN \
  make install

# Install python interface
WORKDIR src/nrnpython
RUN \
   python setup.py install

WORKDIR $HOME/dev

RUN \
  apt-get -y install git
RUN \
  git clone https://github.com/mpi4py/mpi4py

RUN \
  pip install ipython
# WORKDIR mpi4py

# git clone

# RUN \
# mpiexec -np 4

# RUN \
# bash python setup.py build --mpicc=/usr/bin/mpicc


RUN \
  apt-get -y install vim emacs python3-mpi4py



# useradd -ms /bin/bash grover

# USER grover
# WORKDIR /home/grover
# RUN grover

# RUN

# RUN \
#  adduser --disabled-password --gecos '' grover
RUN ls *

RUN adduser --disabled-password --gecos '' r & \
adduser r sudo & \
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# WORKDIR $HOME/dev
# RUN \
#  git clone https://github.com/russelljjarvis/traub_LFPy
# WORKDIR traub_LFPy
# RUN ls *
# RUN mpiexec -np 4 python init.py


