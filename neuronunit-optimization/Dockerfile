# author Russell Jarvis rjjarvis@asu.edu
# author Rick Gerkin rgerkin@asu.edu
# neuronunit-showcase

FROM scidash/neuronunit

#################
# Showcase for model optimization using NeuronUnit.
#################
USER root

RUN apt-get update
RUN apt-get install -y gvfs-bin libxss1 python3-setuptools
RUN apt-get install -y python-tk curl apt-utils


#RUN sudo chown -R jovyan $HOME
#RUN sudo chown -R jovyan /opt/conda/lib/python3.5/site-packages/

USER $NB_USER
RUN pip install --upgrade pip
RUN pip install -U matplotlib
RUN pip install IPython \
                jupyterhub \
                notebook \
                ipykernel \
                ipyparallel \
                enum34 \
		bqplot \ 
		numba

#numba is for optimized code, bqplot is for interactive plotting.
RUN conda install mpi4py
##### Scoop #####

RUN easy_install gevent
RUN easy_install greenlet

WORKDIR $HOME
RUN ls
#RUN sudo rm -r $HOME/scoop
RUN git clone https://github.com/russelljjarvis/scoop.git
#RUN git clone https://github.com/russelljjarvis/scoop.git

WORKDIR $HOME/scoop
RUN python setup.py install
RUN /opt/conda/bin/python setup.py install
##### DEAP ######
WORKDIR $HOME
RUN git clone https://github.com/DEAP/deap.git
WORKDIR deap
RUN python setup.py install

##### BluePyOpt ######
WORKDIR $HOME
RUN git clone https://github.com/russelljjarvis/BluePyOpt.git
WORKDIR BluePyOpt
RUN python setup.py install
RUN python -c "import bluepyopt"

##### Replace PyNeuroML ##########
WORKDIR $HOME
RUN git clone https://github.com/NeuroML/pyNeuroML.git
RUN pwd
RUN ls -ltr *
WORKDIR pyNeuroML
#WORKDIR pyneuroml
#WORKDIR $HOME/PyNeuroML
RUN ls *.py
RUN ls setup.py
RUN sudo /opt/conda/bin/python setup.py install

##### IPython Cluster #####
USER $NB_USER
WORKDIR $HOME
RUN ipython profile create default
RUN pip install git+https://github.com/roryk/ipython-cluster-helper
# Must be done as root to create directories in /usr/local
RUN sudo /opt/conda/bin/ipcluster nbextension enable

RUN jupyter nbextension install --sys-prefix --py ipyparallel
RUN jupyter nbextension enable --sys-prefix --py ipyparallel
RUN jupyter serverextension enable --sys-prefix --py ipyparallel

#Use hack/patch discussed at end of thread until quantities truly becomes compatible with numpy
#https://www.bountysource.com/issues/46022410-valueerror-ufunc-ufunc-positive-not-supported-by-quantities

RUN sudo rm -r /opt/conda/lib/python3.5/site-packages/quantities-0.11.1-py3.5.egg
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
RUN python -c "import scoop"
RUN python -c "import deap"
RUN nrniv

#RUN sudo /opt/conda/bin/pip install sphinx
#RUN sudo git clone https://github.com/russelljjarvis/scoop.git
#RUN sudo /opt/conda/bin/python setup.py install
#RUN export PATH=$PATH

#uncomment the following line to test ipcluster during build.
#RUN ipcluster start --profile=chase --debug &
#https://github.com/russelljjarvis/neuronunit.git
WORKDIR $HOME
ENV PYTHONPATH $HOME/neuronunit:$PYTHONPATH

RUN nrnivmodl
WORKDIR $HOME/neuronunit/neuronunit/tests/

RUN  pip install --upgrade neo


RUN chown -R $NB_USER .
USER $NB_USER

WORKDIR /home/git/neuronunit

RUN sudo chown -R jovyan .

RUN echo "import os">> run_ipp1.p

RUN /opt/conda/bin/ipython3 -c "from ipyparallel import Client; import os; os.system('ipcluster start --profile=chase --debug &')"
WORKDIR $HOME/mnt
RUN sudo chown -R jovyan $HOME



RUN sudo apt-get update
RUN sudo apt-get install -qq gdebi wget libgd2-xpm-dev make
RUN sudo wget -O $HOME/graphviz-2.38.0.deb http://www.graphviz.org/pub/graphviz/stable/ubuntu/ub12.04/x86_64/graphviz_2.38.0-1~precise_amd64.deb
RUN sudo wget -O $HOME/libgraphviz4.deb \
        http://www.graphviz.org/pub/graphviz/stable/ubuntu/ub12.04/x86_64/libgraphviz4_2.38.0-1~precise_amd64.deb
# RUN apt-get remove libcdt4 libpathplan4 libxdot4
# RUN sudo wget -O libgd-xpm.deb http://security.ubuntu.com/ubuntu/pool/main/libg/libgd2/libgd2-xpm_2.0.36~rc1~dfsg-6ubuntu2.1_amd64.deb
# RUN sudo dpkg -i libgd-xpm.deb && apt-get install -f
# RUN sudo yes | gdebi $HOME/libgraphviz4.deb
# RUN sudo yes | gdebi $HOME/graphviz-2.38.0.deb
RUN sudo /opt/conda/bin/pip install https://pypi.python.org/packages/f7/e8/cfad821bc4bc20c2d5ce31dec3378e2791e41ae61a138913ec1462f8d082/neo-0.5.1.tar.gz
RUN conda install python-graphviz graphviz
RUN python -c "from networkx.drawing.nx_agraph import graphviz_layout"