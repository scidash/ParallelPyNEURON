#author russell jarvis rjjarvis@asu.edu

FROM jupyter/scipy-notebook
USER root

#Get a whole lot of GNU core development tools
#version control java development, maven
#Libraries required for building MPI from source
#Libraries required for building NEURON from source

RUN apt-get update && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git gcc g++ build-essential \ 
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    libncurses-dev openmpi-bin openmpi-doc libopenmpi-dev \
    default-jre default-jdk maven emacs
    
USER $NB_USER