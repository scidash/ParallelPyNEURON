FROM scidash/neuronunit-optimization
  # move to a docker install script.

RUN sudo /opt/conda/bin/pip install git+https://github.com/scidash/sciunit.git@dev --process-dependency-links --upgrade
RUN sudo /opt/conda/bin/conda install -y cython
RUN sudo /opt/conda/bin/pip install pynn lazyarray

RUN sudo /opt/conda/bin/pip install git+https://github.com/brian-team/brian2.git
  # faster glif
#RUN sudo /opt/conda/bin/pip install git+https://github.com/russelljjarvis/AllenSDK.git
RUN sudo /opt/conda/bin/conda install -y numpy deap dask numba
RUN sudo /opt/conda/bin/pip install neurodynex

RUN sudo /opt/conda/bin/pip install coverage lmfit
RUN sudo /opt/conda/bin/pip install allensdk #--upgrade
RUN sudo /opt/conda/bin/conda install pandas
RUN sudo /opt/conda/bin/pip install toolz cloudpickle
RUN sudo /opt/conda/bin/pip install setuptools
RUN sudo /opt/conda/bin/conda install -c conda-forge pyscaffold
RUN sudo /opt/conda/bin/pip install --upgrade pip
RUN sudo /opt/conda/bin/conda install python=3.5.0
# RUN sudo /opt/conda/bin/pip install pyscaffold
# RUN sudo /opt/conda/bin/pip install SALib

# RUN git clone https://github.com/SALib/SALib.git
# WORKDIR SALib
# RUN python3 setup.py develop

# uncomment to give PyNN mpi.
# note this is a bad idea. For this project.
# MPI is used for non-embarrasingly parallel computations,
# we use dask here, for embarrassingly parallel.
# RUN sudo apt-get update -y
# RUN sudo apt-get install -y mpich
# RUN pip install mpi4py
RUN pip install git+https://github.com/russelljjarvis/modality