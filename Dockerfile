
#NEURON Dockerfile
#Not docker comments must be of this form.
# This is the syntax for a directive. Don’t get confused


#Set the base image to Ubuntu

FROM ubuntu
	
# author russell jarvis rjjarvis@asu.edu

USER root



RUN apt-get update && \
  apt-get install -y libncurses-dev openmpi-bin openmpi-doc libopenmpi-dev && \
  apt-get install -y wget bzip2 git xterm gcc g++ build-essential default-jre default-jdk emacs python3-mpi4py vim
 


# RUN wget http://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh 
# RUN ls *
# RUN Miniconda3-3.7.0-Linux-x86_64.sh -b -p miniconda


RUN wget http://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh -O miniconda.sh
RUN bash miniconda.sh -b -p $HOME/miniconda
ENV PATH $HOME/miniconda/bin:$PATH
ENV PATH="$HOME/miniconda/bin:$PATH"

#RUN export PATH=“$HOME/miniconda/bin:$PATH"
#RUN export PATH="$HOME/miniconda/bin:$PATH"
#Next  Previous


RUN apt-get install -y gcc g++ build-essential



#RUN export PATH="$HOME/miniconda/bin:$PATH"
#Fetch openmpi source files, extract them, delete .tar.gz file.

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
CMD $HOME/miniconda/bin/python3.4 -c “print(‘blah’)”
CMD python --version
#RUN conda create python=3
#RUN which python
#RUN whereis python
#RUN which python3.4
RUN ./configure --prefix=`pwd` --without-iv --with-nrnpython=$HOME/miniconda/bin/python3.4 --with-paranrn=/usr/bin/mpiexec
RUN make all && \
make install

# Install python interface
WORKDIR src/nrnpython
RUN $HOME/miniconda/bin/python3.4 setup.py install

# RUN apt-get install -y python-setuptools python-dev build-essential


WORKDIR $HOME/git


RUN $HOME/miniconda/bin/conda install scipy numpy
RUN apt-get -y install git xterm


WORKDIR $HOME/git
RUN git clone https://github.com/russelljjarvis/nrnenv
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

RUN apt-get -y install default-jre default-jdk
RUN wget http://apache.mesi.com.ar/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
# RUN tar -xzf apache-maven-3.3.9-bin.tar.gz && \
# RUN rm apache-maven-3.3.9-bin.tar.bz
# WORKDIR apache-maven-3.3.9-bin

# PATH=/apache-maven-3.3.9-bin
RUN $HOME/miniconda/bin/conda install mpi4py
RUN apt-get -y install vim emacs python3-mpi4py

RUN $HOME/miniconda/bin/conda install ipython mpi4py

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


RUN useradd -ms /bin/bash swuser
USER swuser

#RUN mkdir /home/swuser

#RUN chown -R swuser:swuser /home/swuser
#RUN groupadd -r swuser -g 433 

# USER swuser
#RUN mkdir homedir
#RUN groupadd -r swuser -g 433 && \
#useradd -u 431 -r -g swuser -d homedir -s /sbin/nologin -c "Docker image user" swuser && \
#chown -R swuser:swuser homedir


RUN bash -c 'echo “source nrnenv” >> /home/swuser/.bashrc'
ENV HOME=“/home/swuser” 
ENV PATH="$HOME/miniconda/bin:$PATH"


