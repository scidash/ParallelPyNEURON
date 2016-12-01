#author Russell Jarvis rjjarvis@asu.edu
#author Rick Gerkin rgerkin@asu.edu

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
RUN apt-get install -y sudo
    
# Make sure every Python file belongs to jovyan
RUN find /opt/conda ! -user jovyan -print0 | xargs -0 -I {} chown jovyan {}
# Remove dangling symlinks
RUN find -L /opt/conda -type l -delete
# Make sure every Python file is writable
RUN find /opt/conda ! -writable -print0 | xargs -0 -I {} chmod 744 {}

RUN chown -R jovyan $HOME
RUN rm -rf /var/lib/apt/lists/*
RUN echo "jovyan ALL=NOPASSWD: ALL" >> /etc/sudoers

USER $NB_USER