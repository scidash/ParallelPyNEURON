#author russell jarvis rjjarvis@asu.edu
#NEURON Dockerfile
#Set the base image to Ubuntu
FROM scidash/scipy-notebook-plus

#Get a whole lot of GNU core development tools
#version control java development, maven
#Libraries required for building MPI from source
#Libraries required for building NEURON from source
#Also DO this part as root.
USER root

RUN apt-get update && apt-get install -y wget bzip2 ca-certificates default-jre default-jdk maven automake libtool  \
                       wget python3 libpython3-dev libncurses5-dev libreadline-dev libgsl0-dev cython3 \
                       python3-pip python3-numpy python3-scipy python3-matplotlib python3-mock \
                       ipython3 python3-docutils \
                       python3-mpi4py cmake ssh

RUN sudo /opt/conda/bin/conda install scipy numpy matplotlib


#Do the rest of the build  as user:
#This will create a more familiar environment to continue developing in.
#with less of a need to chown and chmod everything done as root at dockerbuild completion

USER jovyan
WORKDIR /home/jovyan
RUN sudo chown -R jovyan /home/jovyan
ENV HOME /home/jovyan
ENV PATH /opt/conda/bin:/opt/conda/bin/conda:/opt/conda/bin/python:$PATH

#Test matplotlib
#RUN python -c "import matplotlib"
#Install General MPI, such that mpi4py can later bind with it.
WORKDIR /home/jovyan

WORKDIR $HOME
RUN \
  wget http://www.neuron.yale.edu/ftp/neuron/versions/v7.4/nrn-7.4.tar.gz && \
  tar -xzf nrn-7.4.tar.gz && \
  rm nrn-7.4.tar.gz

WORKDIR $HOME/nrn-7.4
ENV PATH /usr/bin/python3/python:/opt/conda/bin:/opt/conda/bin/conda:/opt/conda/bin/python:$PATH
RUN ./configure --prefix=`pwd` --with-paranrn --without-iv --with-nrnpython=/usr/bin/python3
RUN sudo make all && \
   make install

ENV HOME /home/jovyan
ENV PATH $HOME/nrn-7.4/x86_64/bin:$PATH
ENV PATH /opt/conda/bin:/opt/conda/bin/conda:/opt/conda/bin/python:$PATH


RUN sudo chown -R jovyan /home/jovyan
WORKDIR /home/jovyan/nrn-7.4/src/parallel
RUN nrniv test0.hoc
RUN mpiexec -np 4 nrniv -mpi test0.hoc
RUN mpiexec -np 4 nrniv -mpi test1.hoc
RUN mpiexec -np 4 nrniv -mpi test2.hoc
RUN mpiexec -np 4 nrniv -mpi test3.hoc
RUN mpiexec -np 4 nrniv -mpi test4.hoc
RUN mpiexec -np 4 nrniv -mpi test5.hoc
RUN mpiexec -np 4 nrniv -mpi test6.hoc
RUN mpiexec -np 4 nrniv -mpi test7.hoc

ADD ./test_fixed.py /home/docker/nrn-7.4/src/parallel/
RUN mpiexec -np 4 nrniv -mpi -python test_fixed.py

RUN sudo /opt/conda/bin/pip install zmq
RUN sudo /opt/conda/bin/pip install packaging
#RUN sudo /opt/conda/bin/pip install --upgrade pip#notebook
RUN sudo /opt/conda/bin/pip install notebook
RUN sudo /opt/conda/bin/pip install ipyparallel
RUN which /opt/conda/bin/ipcluster
RUN sudo /opt/conda/bin/ipcluster nbextension enable
RUN sudo /opt/conda/bin/ipython profile create chase
ENV PYTHONPATH "/opt/conda/bin/python3.5/dist-packages"
RUN echo $PYTHONPATH
RUN which python
RUN /opt/conda/bin/ipython -c "import sys; print(sys.path)"
RUN /opt/conda/bin/ipython -c "from ipyparallel import Client"
#RUN /opt/conda/bin/ipython -c "import os;os.system('ipcluster start -n 4 --engines=MPIEngineSetLauncher')"

#RUN sudo ipcluster start --profile=chase --debug &
#RUN mpiexec -n 4 ipengine --mpi=mpi4pyB