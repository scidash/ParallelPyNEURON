# author Russell Jarvis rjjarvis@asu.edu
# author Rick Gerkin rgerkin@asu.edu
# neuronunit-showcase

FROM scidash/neuronunit-optimization
RUN sudo rm -rf /opt/conda/lib/python3.5/site-packages/setuptools-27.2.0-py3.5.egg
RUN sudo /opt/conda/bin/pip install --upgrade pip
RUN sudo /opt/conda/bin/pip install --upgrade setuptools
RUN sudo rm -rf /opt/conda/lib/python3.5/site-packages/allensdk-0.12.4.1-py3.5.egg
RUN pip install git+https://github.com/fun-zoological-computing/AllenSDK.git
# RUN conda update -n base conda
USER $NB_USER

# RUN pip uninstall tornado
# move to a docker install script.
RUN sudo /opt/conda/bin/pip install --upgrade pip
# RUN sudo /opt/conda/bin/pip install git+https://github.com/scidash/sciunit.git@dev # --upgrade# --process-dependency-links --upgrade
RUN sudo /opt/conda/bin/conda install -y cython

RUN sudo /opt/conda/bin/pip install git+https://github.com/brian-team/brian2.git
# faster glif
# RUN sudo /opt/conda/bin/pip install allensdk --upgrade
# RUN sudo /opt/conda/bin/conda install -y numpy deap dask numba
# RUN sudo /opt/conda/bin/pip install allensdk --upgrade

RUN sudo /opt/conda/bin/pip install git+git://github.com/BlueBrain/eFEL

WORKDIR $HOME
# RUN sudo /opt/conda/bin/pip install git+
# RUN git clone https://github.com/AllenInstitute/sonata
# WORKDIR /sonata/src/pysonata
# RUN echo $pwd
# RUN ls *.py
# RUN python setup.py install

RUN git clone https://github.com/AllenInstitute/bmtk.git
WORKDIR bmtk
RUN python setup.py install

WORKDIR $HOME
RUN sudo apt-get update -y 
RUN sudo apt-get upgrade -y 
RUN sudo apt-get -y install libhdf5-dev vim
# RUN sudo /opt/bin/conda/pip install setuptools
# RUN sudo /opt/conda/bin/pip install --upgrade protobuf 

# RUN git clone
# ing/AllenSDK
# WORKDIR AllenSDK
# RUN python setup.py install
RUN sudo /opt/conda/bin/pip3 install pyscaffold
RUN sudo /opt/conda/bin/pip install pip --upgrade
RUN sudo /opt/conda/bin/pip3 install SALib
# git+https://github.com/SALib/SALib.git

ENTRYPOINT /bin/bash