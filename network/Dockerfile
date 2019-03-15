
  # move to a docker install script.

RUN sudo /opt/conda/bin/pip install git+https://github.com/scidash/sciunit.git@dev --process-dependency-links --upgrade
RUN sudo /opt/conda/bin/conda install -y cython
RUN sudo /opt/conda/bin/pip install pynn lazyarray

RUN sudo /opt/conda/bin/pip install git+https://github.com/brian-team/brian2.git
  # faster glif
RUN sudo /opt/conda/bin/pip install git+https://github.com/russelljjarvis/AllenSDK.git
RUN sudo /opt/conda/bin/conda install -y numpy deap dask numba
RUN sudo /opt/conda/bin/pip install allensdk --upgrade
RUN sudo /opt/conda/bin/pip install neurodynex
RUN sudo /opt/conda/bin/pip install coverage lazyarray lmfit
