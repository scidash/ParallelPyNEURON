

FROM scidash/neuronunit-optimization
RUN git clone -b dev https://github.com/russelljjarvis/informatics_poster.git
WORKDIR informatics_poster/neuronunit/optimization
WORKDIR NeuroML2
RUN nrnivmodl
WORKDIR informatics_poster/neuronunit/optimization
ENTRYPOINT ipcluster start -n 8 --profile=default & sleep 5 && ipython -i nsga_parallel_no_vm.py


