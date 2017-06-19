FROM scidash/neuron-mpi-neuroml

RUN /opt/conda/bin/ipython3 setup.py install
RUN /opt/conda/bin/ipython -c "from neuron import h"
RUN /opt/conda/bin/ipython3 -c "from neuron import h"

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
ADD ./test_fixed.py /home/jovyan/nrn-7.4/src/parallel/
ADD ./test_fixed2.py /home/jovyan/nrn-7.4/src/parallel/

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
RUN /opt/conda/bin/ipython3 -c "import sys; print(sys.path)"
RUN /opt/conda/bin/ipython3 -c "from ipyparallel import Client"
#RUN /opt/conda/bin/ipython -c "import os;os.system('ipcluster start -n 4 --engines=MPIEngineSetLauncher')"

#RUN sudo ipcluster start --profile=chase --debug &
#RUN mpiexec -n 4 ipengine --mpi=mpi4py

COPY ./test_fixed.py /home/jovyan/nrn-7.4/src/parallel
COPY ./test_fixed2.py /home/jovyan/nrn-7.4/src/parallel
RUN ls /home/jovyan/nrn-7.4/src/parallel/*.py
RUN ls *.py
RUN pwd

RUN ls /home/jovyan/nrn-7.4/src/parallel/test_fixed2.py
RUN echo "import os">> run_ipp1.py
#RUN echo "os.system('ipcluster start --profile=chase --debug &')" >> run_ipp1.py
RUN echo "os.system('ipcluster start -n 4 --engines=MPIEngineSetLauncher --profile=chase --debug &')" >> run_ipp1.py
#RUN conda install mpi4py
#RUN echo "import ipyparallel as ipp ; rc = ipp.Client(profile='chase'); print('hello from before cpu '); print(rc.ids);" >> run_ipp2.py
#RUN ipython run_ipp1.py && sleep 15 && ipython run_ipp2.py
RUN /opt/conda/bin/ipython3 -c "from neuron import h"

RUN /opt/conda/bin/ipython3 run_ipp1.py && sleep 15 && mpiexec -n 4 nrniv -mpi -python /home/jovyan/nrn-7.4/src/parallel/test_fixed2.py
#RUN /opt/conda/bin/ipython3 run_ipp1.py && sleep 15 && mpiexec -n 4 /opt/conda/bin/ipengine --mpi=mpi4py /home/jovyan/nrn-7.4/src/parallel/test_fixed2.py
