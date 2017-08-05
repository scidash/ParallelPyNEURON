

FROM scidash/neuronunit-optimization
RUN git clone -b dev https://github.com/russelljjarvis/informatics_poster.git
RUN sudo chown -R jovyan $HOME
WORKDIR informatics_poster/neuronunit/optimization
RUN nrnivmodl NeuroML2
ENTRYPOINT ipcluster start -n 8 --profile=default & sleep 5 && ipython -i nsga_parallel_no_vm.py


