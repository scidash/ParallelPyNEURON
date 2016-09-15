#author russell jarvis rjjarvis@asu.edu

#NEURON Dockerfile
#Docker comments must be of this form.
# This is the syntax for a directive. Don’t get confused
#Set the base image to Ubuntu

FROM ubuntu

#DO this part as root.
#This is copied from the docker container for anaconda

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh -O miniconda.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh


#RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
#    wget --quiet https://repo.continuum.io/miniconda/Miniconda2-4.0.5-Linux-x86_64.sh -O ~/miniconda.sh && \
#    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
#    rm ~/miniconda.sh
    

#RUN apt-get install -y curl grep sed dpkg && \
#    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
#    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
#    dpkg -i tini.deb && \
#    rm tini.deb && \
#    apt-get clean

#ENV PATH /opt/conda/bin:$PATH

#Do the rest of the build  as user:
#This will create a more familiar environment to continue developing in.

RUN useradd -ms /bin/bash docker

USER root
RUN apt-get update \
      && apt-get install -y sudo \
      && rm -rf /var/lib/apt/lists/*
RUN echo "docker ALL=NOPASSWD: ALL" >> /etc/sudoers
#CMD cat /etc/sudoers 


USER docker
WORKDIR /home/docker
RUN chown -R docker:docker /home/docker

#ENV PATH /opt/conda/bin:$PATH
RUN /opt/conda/bin/python -c "print('hello?')"
RUN sudo python -c "print('hello')"
RUN sudo /opt/conda/bin/conda install scipy numpy

#Get a whole lot of GNU core development tools

RUN sudo apt-get update && \
  sudo apt-get install -y libncurses-dev openmpi-bin openmpi-doc libopenmpi-dev 

RUN sudo apt-get install -y wget bzip2 git xterm gcc g++ build-essential default-jre default-jdk emacs vim  bzip2 ca-certificates 

RUN sudo apt-get install -y libglib2.0-0 libxext6 libsm6 libxrender1 git mercurial subversion

RUN sudo apt-get install -y gcc g++ build-essential


#RUN sudo wget http://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh -O miniconda.sh
#RUN sudo bash miniconda.sh -b -p $HOME/miniconda


#Desperately try to set environmentle variables, 
#It would be great to know which of the following statements are effective.


#CMD PATH="$HOME/miniconda/bin:$PATH"
#CMD PYTHONPATH="$HOME/miniconda/bin:$PATH"
#ENV PYTHONPATH $HOME/miniconda/bin:$PATH
#RUN alias conda='bash /home/docker/miniconda/bin/conda'

#CMD source $PATH
#CMD source $PYTHONPATH

#Only the following statements are effective at setting path, and the one that sets home.
#The statements that set paths above are not effective
#however these steps below are effective, so they will replace the ones above.


ENV HOME /home/docker 
CMD HOME="/home/docker"
RUN unset PYTHONPATH
RUN unset PYTHONHOME
RUN export PYTHONPATH=/opt/conda/bin/python
RUN export PYTHONHOME=/opt/conda/bin/python



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
#RUN sudo wget http://apache.mesi.com.ar/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
#RUN sudo tar -xzf apache-maven-3.3.9-bin.tar.gz
#RUN sudo rm apache-maven-3.3.9-bin.tar.gz
#WORKDIR $HOME/apache-maven-3.3.9-bin/



#export PATH=/opt/apache-maven-3.3.9/bin:$PATH
#RUN export PATH=$HOME/apache-maven-3.3.9-bin/bin:$PATH

#RUN ln -s apach

#TODO: Download jNeuroML at some stage here.

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


#RUN sudo apt-get install xterm maven
#WORKDIR $HOME/git
#RUN sudo git clone https://github.com/NeuroML/jNeuroML.git
#WORKDIR jNeuroML
#RUN sudo python getNeuroML.py



#RUN sudo apt-get -y install git xterm maven

#WORKDIR $HOME/git
#RUN sudo git clone https://github.com/scidash/sciunit
#WORKDIR sciunit
#RUN sudo python setup.py install
#WORKDIR $HOME/git

#RUN sudo git clone https://github.com/scidash/neuronunit
#RUN git branch dev
#RUN git pull origin dev
#WORKDIR neuronunit

#RUN sudo python setup.py install
#WORKDIR $HOME/git
#RUN git branch dev
#RUN git pull origin dev

#The repository below is only usefull for testing if MPI+PY+NEURON work okay togethor
RUN sudo git clone https://github.com/russelljjarvis/traub_LFPy


#RUN cp $HOME/git/nrnenv/nrnenv $HOME
RUN echo "export N=$HOME/neuron/nrn-7.4">>~/.bashrc
RUN echo "export CPU=x86_64">>~/.bashrc
RUN path_string="$IV/$CPU/bin:$N/$CPU/bin:$PATH"
RUN echo "export PATH=${path_string}">>~/.bashrc	


#RUN eval echo "export PATH=\"$IV/$CPU/bin:$N/$CPU/bin:$PATH\"">>~/.bashrc


#make sure the user can execute all the source code installed to their user space.
#installing with sudo can sometimes make root the owner of files for reasons I don't understand

RUN sudo chown -R docker $HOME



#Cruft to delete follows:

#RUN sudo conda
#RUN sudo apt-get -y install vim emacs python3-mpi4py
#RUN sudo $HOME/miniconda/bin/conda install ipython mpi4py
#RUN sudo chown -R docker $HOME
#ENV PYTHONHOME /home/docker/miniconda/bin/python3
#ENV PYTHONHOME /home/docker/miniconda/bin/python3

#RUN sudo apt-get install docker

#RUN echo "source nrnenv" >> ~/.bashrc
#RUN echo "source nrnenv" >> ~/.profile 
#RUN export PATH=“$HOME/miniconda/bin:$PATH"
#RUN export PATH="$HOME/miniconda/bin:$PATH"
#Next Previous
#RUN export PATH="$HOME/miniconda/bin:$PATH"
#Fetch openmpi source files, extract them, delete .tar.gz file.
#RUN conda create python=3
#RUN which python
#RUN whereis python
#RUN which python3.4


#RUN apt-get update && \
#  apt-get install -y libncurses-dev openmpi-bin openmpi-doc libopenmpi-dev && \
#  apt-get install -y wget bzip2 git xterm gcc g++ build-essential default-jre d#efault-jdk emacs python3-mpi4py vim
#USER root
#RUN apt-get update && \
#      apt-get -y install sudo
#RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
#USER docker
#CMD /bin/bash
#RUN useradd -ms /bin/bash swuser

#USER swuser
#RUN bash -c 'echo “source nrnenv” >> /home/swuser/.bashrc'
#ENV HOME=“/home/swuser” 
#ENV PATH="$HOME/miniconda/bin:$PATH"
#RUN su docker -c "apt-get install -y wget vim"
#CMD /bin/bash
# RUN wget http://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh 
# RUN ls *
# RUN Miniconda3-3.7.0-Linux-x86_64.sh -b -p miniconda

# WORKDIR nrnenv
# RUN cp nrnenv $HOME
# echo “source nrnenv” >> ~/.bashrc
# RUN create_user_in_docker.sh

# RUN apt-get -y install xterm

# WORKDIR $HOME/git/mpi4py

# RUN ls *.py
# apt-get install -y python-pip && \	
# RUN python setup.py install
# RUN python setup.py build --mpicc=/usr/bin/mpicc


#WORKDIR $HOME/git
#RUN git clone https://github.com/hglabska/Thalamocortical_imem
#WORKDIR Thalamocortical_imem
#RUN $HOME/miniconda/bin/python3.4 setup.py install
#WORKDIR $HOME/git
#RUN git clone https://github.com/espenhgn/LFPy
#WORKDIR LFPy
#RUN $HOME/miniconda/bin/python3.4 setup.py install
#WORKDIR $HOME/git


# RUN tar -xzf apache-maven-3.3.9-bin.tar.gz && \
# RUN rm apache-maven-3.3.9-bin.tar.bz
# WORKDIR apache-maven-3.3.9-bin
# PATH=/apache-maven-3.3.9-bin


#EXPOSE 27017
#CMD ["--port 27017"]
#ENTRYPOINT usr/bin/mongod
#WORKDIR $HOME/git
#RUN git clone git://github.com/NeuroML/jNeuroML.git# neuroml_git/jNeuroML
#WORKDIR jNeuroML
#RUN $HOME/miniconda/bin/python3.4 getNeuroML.py # gitelopment
# WORKDIR mpi4py
#RUN git clone https://github.com/mpi4py/mpi4py.git
#WORKDIR mpi4py 
#RUN $HOME/miniconda/bin/python3.4 setup.py install # build --mpicc=/usr/bin/mpicc
#RUN $HOME/miniconda/bin/conda install sciunit
#RUN groupadd -r swuser -g 433 && \
#useradd -u 431 -r -g swuser -d $HOME -s /sbin/nologin "Docker image user" swuser && \
#chown -R swuser:swuser $HOME
#RUN mkdir /home/swuser
#RUN chown -R swuser:swuser /home/swuser
#RUN groupadd -r swuser -g 433 
# USER swuser
#RUN mkdir homedir
#RUN groupadd -r swuser -g 433 && \
#useradd -u 431 -r -g swuser -d homedir -s /sbin/nologin -c "Docker image user" swuser && \
#chown -R swuser:swuser homedir



