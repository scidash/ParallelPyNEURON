#
# NEURON Dockerfile
#

# Pull base image.
# FROM andrewosh/binder-base

# Set the base image to Ubuntu
FROM ubuntu

# MAINTAINER Alex Williams <alex.h.willia@gmail.com>
# and russell jarvis rjjarvis@asu.edu


USER root

RUN \
  apt-get update && \
  apt-get install -y libncurses-dev

RUN \
   wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
   bash Miniconda2-latest-Linux-x86_64.sh
# Make ~/neuron directory to hold stuff.
WORKDIR neuron

# Fetch openmpi source files, extract them, delete .tar.gz file.

RUN \
   wget https://www.open-mpi.org/software/ompi/v2.0/downloads/openmpi-2.0.0.tar.gz
   tar -xzf openmpi-2.0.0.tar.gz && \
   rm openmpi-2.0.0.tar.gz

WORKDIR openmpi-2.0.0

# Compile NEURON.
RUN \
  ./configure 


# Fetch NEURON source files, extract them, delete .tar.gz file.
RUN \
  wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.4/nrn-7.4.tar.gz && \
  tar -xzf nrn-7.4.tar.gz && \
  rm nrn-7.4.tar.gz && \
  make all && \
  make install

# Fetch Interviews.
# RUN \
#  wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.4/iv-19.tar.gz  && \  
#  tar -xzf iv-19.tar.gz && \
#  rm iv-19.tar.gz

WORKDIR nrn-7.4

# Compile NEURON.
RUN \
  ./configure --prefix=`pwd` --without-iv --with-nrnpython=$HOME/miniconda2/bin/python --with-paranrn=/usr/bin/mpiexec &&   make &&   make install

  make all && \
  make install

# Install python interface
WORKDIR src/nrnpython
RUN python setup.py install

