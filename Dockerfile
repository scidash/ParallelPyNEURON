#author russell jarvis rjjarvis@asu.edu
#NEURON Dockerfile
#Set the base image to Ubuntu
FROM ubuntu
#Get a whole lot of GNU core development tools
#version control java development, maven
#Libraries required for building MPI from source
#Libraries required for building NEURON from source
#Also DO this part as root.

RUN apt-get update && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git gcc g++ build-essential \ 
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    libncurses-dev openmpi-bin openmpi-doc libopenmpi-dev \
    default-jre default-jdk maven emacs
    
RUN apt-get update; apt-get install -y automake libtool git vim  \
                       wget python3 libpython3-dev libncurses5-dev libreadline-dev libgsl0-dev cython3 \
                       python3-pip python3-numpy python3-scipy python3-matplotlib python3-mock \
                       ipython3 python3-docutils python3-yaml \
                       python3-venv python3-mpi4py python3-tables cmake


#The following code is adapted from:
#https://github.com/ContinuumIO/docker-images/blob/master/anaconda/Dockerfile    

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh -O miniconda.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh
    
#Do the rest of the build  as user:
#This will create a more familiar environment to continue developing in.
#with less of a need to chown and chmod everything done as root at dockerbuild completion

RUN useradd -ms /bin/bash docker
USER root
RUN apt-get update \
      && apt-get install -y sudo \
      && rm -rf /var/lib/apt/lists/*
RUN echo "docker ALL=NOPASSWD: ALL" >> /etc/sudoers

USER docker
WORKDIR /home/docker
RUN chown -R docker:docker /home/docker
ENV HOME /home/docker 
ENV PATH /opt/conda/bin:/opt/conda/bin/conda:/opt/conda/bin/python:$PATH
RUN sudo /opt/conda/bin/conda install scipy numpy matplotlib

#Test matplotlib
RUN /opt/conda/bin/python -c "import matplotlib"
#Install General MPI, such that mpi4py can later bind with it.

#WORKDIR $HOME

#Install NEURON-7.4 with python, with MPI. An infamous build process,
#and much of the motivation for this docker container
# Fetch NEURON source files, extract them, delete .tar.gz file.

#Create python bindings for NEURON
#WORKDIR src/nrnpython
#RUN sudo python setup.py install
#--with-nrnpython=/opt/conda/bin/python
RUN which mpirun  
#RUN mpirun -np 4 nrniv -mpi $HOME/neuron/nrn-7.4/src/parallel/test1.hoc
#RUN /usr/bin/mpiexec -np 4 nrniv -mpi $HOME/neuron/nrn-7.4/src/parallel/test2.hoc
WORKDIR /home/docker
ENV HOME /home/docker 
RUN echo 'rerun'
WORKDIR $HOME
RUN \
  wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.4/nrn-7.4.tar.gz && \
  tar -xzf nrn-7.4.tar.gz && \
  rm nrn-7.4.tar.gz 

WORKDIR $HOME/nrn-7.4
RUN whereis python3
ENV PATH /usr/bin/python3/python:/opt/conda/bin:/opt/conda/bin/conda:/opt/conda/bin/python:$PATH
#RUN ls -ltr configure
RUN ./configure --prefix=`pwd` --with-paranrn --without-iv --with-nrnpython=/usr/bin/python3 
RUN make all && \
   make install
ENV PATH $HOME/nrn-7.4/x86_64/bin:$PATH

    
RUN useradd -ms /bin/bash docker
USER root
RUN apt-get update \
      && apt-get install -y sudo \
      && rm -rf /var/lib/apt/lists/*
RUN echo "docker ALL=NOPASSWD: ALL" >> /etc/sudoers




ENV HOME /home/docker 
ENV PATH $HOME/nrn-7.4/x86_64/bin:$PATH
ENV PATH /opt/conda/bin:/opt/conda/bin/conda:/opt/conda/bin/python:$PATH





RUN apt-get update && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git gcc g++ build-essential \ 
    libncurses-dev openmpi-bin openmpi-doc libopenmpi-dev \
    default-jre default-jdk maven emacs

WORKDIR $HOME/git
#TODO change back to this repository, once pull request as accepted for python3 compliant code
#RUN sudo git clone https://github.com/NeuroML/jNeuroML
RUN git clone https://github.com/russelljjarvis/jNeuroML.git
WORKDIR jNeuroML
RUN python getNeuroML.py

    
USER docker
RUN sudo chown -R docker:docker /home/docker
#WORKDIR $HOME/nrn-7.4/src/parallel
#RUN mpiexec -np 4 nrniv -mpi test0.hoc



