# author Russell Jarvis rjjarvis@asu.edu
# author Rick Gerkin rgerkin@asu.edu
# neuronunit-showcase

FROM scidash/neuronunit

#################
# Showcase for model optimization using NeuronUnit.
#################
USER root

RUN apt-get update --fix-missing
RUN apt-get -y upgrade
RUN apt-get dist-upgrade
RUN apt-get update && \
    apt-get -y install gcc && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get autoremove -y
RUN apt-get -y update
#RUN apt-get install -y apt-transport-https# ca-certificates
RUN apt-get install -y python3-setuptools
RUN apt-get install -y python-tk curl apt-utils


#RUN sudo chown -R jovyan $HOME
#RUN sudo chown -R jovyan /opt/conda/lib/python3.5/site-packages/

RUN pip install --upgrade pip
RUN pip install -U matplotlib
RUN pip install IPython \
                jupyterhub \
                notebook \
                ipykernel \
                ipyparallel \
                enum34 

RUN pip install bqplot numba 

#numba is for optimized code, bqplot is for interactive plotting.
#RUN conda install mpi4py
##### Scoop #####

RUN easy_install gevent
RUN easy_install greenlet

##### DEAP ######
WORKDIR $HOME
RUN git clone https://github.com/DEAP/deap.git
#https://github.com/DEAP/deap.git
WORKDIR $HOME/deap
RUN python setup.py install

RUN apt-get update && \
    apt-get -y install gcc
RUN apt-get autoremove
RUN apt-get upgrade
RUN sudo apt-get -y install python-dev
##### BluePyOpt ######
#WORKDIR $HOME
#RUN git clone https://github.com/russelljjarvis/BluePyOpt.git
#WORKDIR BluePyOpt
#RUN python setup.py install
#RUN python -c "import bluepyopt"


RUN /opt/conda/bin/pip install mpi4py

##### Replace PyNeuroML ##########
WORKDIR $HOME
RUN git clone https://github.com/NeuroML/pyNeuroML.git
WORKDIR pyNeuroML
RUN ls *.py
RUN ls setup.py
RUN pip install --process-dependency-links -e .
#RUN sudo /opt/conda/bin/python setup.py install

##### IPython Cluster #####
USER $NB_USER
WORKDIR $HOME
RUN ipython profile create default
RUN pip install git+https://github.com/roryk/ipython-cluster-helper
# Must be done as root to create directories in /usr/local
RUN sudo /opt/conda/bin/ipcluster nbextension enable

RUN sudo /opt/conda/bin/pip install git+https://github.com/russelljjarvis/gprof2dot.git

RUN jupyter nbextension install --sys-prefix --py ipyparallel
RUN jupyter nbextension enable --sys-prefix --py ipyparallel
RUN jupyter serverextension enable --sys-prefix --py ipyparallel

#RUN sudo rm -r /opt/conda/lib/python3.5/site-packages/quantities-0.11.1-py3.5.egg
RUN /opt/conda/bin/pip install --upgrade git+git://github.com/python-quantities/python-quantities.git@master
RUN python -c "import quantities as pq"
RUN python -c "import sciunit.scores"

#RUN git clone -b "master" git://github.com/python-quantities/python-quantities.git
#WORKDIR python-quantities
#RUN sudo ln -s quantities /opt/conda/lib/python3.5/site-packages/quantities-0.11.1-py3.5.egg
#RUN sudo ln -s quantities /opt/conda/lib/python3.5/site-packages/quantities

RUN python -c "import quantities"
RUN printenv PATH
RUN python -c "import pyneuroml"
RUN python -c "import neuronunit"
RUN python -c "from neuronunit.models.reduced import ReducedModel"
#RUN conda install quantities
RUN python -c "import neuron"
RUN python -c "import pyneuroml"
RUN nrnivmodl
RUN /opt/conda/bin/pip install graphviz

RUN git clone https://github.com/soravux/scoop.git
WORKDIR scoop
RUN sudo /opt/conda/bin/python setup.py install
RUN python -c "import scoop"
RUN python -c "import deap"
RUN nrniv
WORKDIR $HOME
ENV PYTHONPATH $HOME/neuronunit:$PYTHONPATH

RUN nrnivmodl
WORKDIR $HOME/neuronunit/neuronunit/tests/
RUN sudo /opt/conda/bin/pip install https://pypi.python.org/packages/f7/e8/cfad821bc4bc20c2d5ce31dec3378e2791e41ae61a138913ec1462f8d082/neo-0.5.1.tar.gz
RUN  pip install --upgrade neo

RUN /opt/conda/bin/pip install https://pypi.python.org/packages/f7/e8/cfad821bc4bc20c2d5ce31dec3378e2791e41ae61a138913ec1462f8d082/neo-0.5.1.tar.gz
RUN conda install python-graphviz graphviz
WORKDIR /home/git
USER root
RUN chown -R $NB_USER .
USER $NB_USER

WORKDIR /home/git/neuronunit

RUN sudo chown -R jovyan .

RUN echo "import os">> run_ipp1.p

RUN /opt/conda/bin/ipython3 -c "from ipyparallel import Client; import os; os.system('ipcluster start --profile=chase --debug &')"
WORKDIR $HOME/mnt
RUN sudo chown -R jovyan $HOME

#USER root
RUN sudo cat /etc/apt/sources.list
# RUN conda install python-graphviz graphviz
# Note igraph as distinguished from python-igraph is actually jgraph, something else entirely
RUN sudo apt-get update
RUN sudo apt-get install -y python-dev graphviz libgraphviz-dev pkg-config
RUN sudo /opt/conda/bin/pip install git+https://github.com/pygraphviz/pygraphviz.git
RUN python -c "from networkx.drawing.nx_agraph import graphviz_layout"

RUN sudo /opt/conda/bin/pip install plotly cufflinks

WORKDIR $HOME
RUN python -c "import sciunit"

COPY stdout_worker.py $HOME/stdout_worker.py
COPY func2rc.sh $HOME/func2rc.sh
RUN cat $HOME/func2rc.sh >> ~/.bashrc
RUN sudo chown -R jovyan /home/jovyan/work
ENV QT_QPA_PLATFORM offscreen
ENV PYTHONPATH $PYTHONPATH/home/jovyan/neuronunit/neuronunit/optimization

WORKDIR $HOME/neuronunit/neuronunit
RUN conda install dask
WORKDIR $HOME
RUN rm -r $HOME/neuronunit
RUN git clone -b dev https://github.com/russelljjarvis/neuronunit.git
RUN /bin/bash -c "source $HOME/func2rc.sh"
WORKDIR $HOME/neuronunit/neuronunit/optimization
RUN cat nsga_parallel.py
RUN sudo chown -R jovyan $HOME
RUN sudo cp $HOME/func2rc.sh .

#RUN /bin/bash func2rc.sh
ENV PYTHONPATH "/home/jovyan/neuronunit"
ENTRYPOINT ipcluster start -n 8 --profile=default & sleep 10 ; python stdout_worker.py & ipython -i nsga_parallel.py /bin/bash