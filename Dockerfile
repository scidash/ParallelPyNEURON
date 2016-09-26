#author russell jarvis rjjarvis@asu.edu

#NEURON Dockerfile
#Docker comments must be of this form.
# This is the syntax for a directive. Don’t get confused
#Set the base image to Ubuntu

FROM ubuntu

#DO this part as root.
#This is copied from the docker container for anaconda

RUN apt-get update && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git 

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh -O miniconda.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh
    


#Do the rest of the build  as user:
#This will create a more familiar environment to continue developing in.

RUN useradd -ms /bin/bash docker

USER root
RUN apt-get update \
      && apt-get install -y sudo \
      && rm -rf /var/lib/apt/lists/*
RUN echo "docker ALL=NOPASSWD: ALL" >> /etc/sudoers


USER docker
WORKDIR /home/docker

RUN chown -R docker:docker /home/docker

#ENV PATH "/opt/conda/bin:$PATH"
#RUN echo $PATH



ENV HOME /home/docker 
RUN echo $HOME

#ENV PYTHONPATH /opt/conda/bin/
#ENV PYTHONHOME /opt/conda/bin/
ENV PATH /opt/conda/bin:/opt/conda/bin/conda:/opt/conda/bin/python:$PATH
RUN echo $PATH
#RUN echo $PYTHONPATH
#RUN echo $PYTHONHOME


#RUN export PYTHONHOME=/opt/conda/bin/python
#RUN echo $PATH
#RUN echo $PYTHONHOME
#RUN echo $PYTHONPATH
#RUN /opt/conda/bin/python -c "print('hello?')"
#RUN python -c "print('hello')"
RUN which conda
RUN whereis condo
RUN sudo /opt/conda/bin/conda install scipy numpy

#Get a whole lot of GNU core development tools

RUN sudo apt-get update && \
  sudo apt-get install -y libncurses-dev openmpi-bin openmpi-doc libopenmpi-dev 

RUN sudo apt-get install -y wget bzip2 git gcc g++ build-essential default-jre default-jdk emacs vim ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 




#Install General MPI, such that mpi4py can later bind with it.


WORKDIR /home/docker

RUN \
   sudo wget https://www.open-mpi.org/software/ompi/v2.0/downloads/openmpi-2.0.0.tar.gz && \
   sudo tar -xzf openmpi-2.0.0.tar.gz && \
   sudo rm openmpi-2.0.0.tar.gz

WORKDIR /home/docker/openmpi-2.0.0

# Compile openmpi
RUN \
  sudo ./configure && \
  sudo make all && \
  sudo make install

#Download  maven, and its java dependencies

WORKDIR $HOME/git
RUN sudo apt-get -y install default-jre default-jdk maven

WORKDIR $HOME
RUN sudo /opt/conda/bin/conda install -y mpi4py ipython


#Install NEURON-7.4 with python, with MPI. An infamous build process,
#and much of the motivation for this docker container


WORKDIR /home/docker/neuron
# Fetch NEURON source files, extract them, delete .tar.gz file.
RUN \
  sudo wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.4/nrn-7.4.tar.gz && \
  sudo tar -xzf nrn-7.4.tar.gz && \
  sudo rm nrn-7.4.tar.gz 

WORKDIR /home/docker/neuron/nrn-7.4


RUN sudo ./configure --prefix=`pwd` --without-iv --with-nrnpython=/opt/conda/bin/python --with-paranrn=/usr/bin/mpiexec
RUN sudo make all && \
   sudo make install


WORKDIR src/nrnpython
RUN sudo /opt/conda/bin/python setup.py install

#Probably these statements were causing mayhem.

#RUN cp $HOME/git/nrnenv/nrnenv $HOME
#RUN echo "export N=$HOME/neuron/nrn-7.4">>~/.bashrc
#RUN echo "export CPU=x86_64">>~/.bashrc
#RUN path_string="$IV/$CPU/bin:$N/$CPU/bin:$PATH"
#RUN echo "export PATH=${path_string}">>~/.bashrc	


#RUN eval echo "export PATH=\"$IV/$CPU/bin:$N/$CPU/bin:$PATH\"">>~/.bashrc


#make sure the user can execute all the source code installed to their user space.
#installing with sudo can sometimes make root the owner of files for reasons I don't understand

RUN sudo chown -R docker $HOME
#ENV PYTHONPATH /opt/conda/bin/python
#ENV PYTHONHOME /opt/conda/bin/python




