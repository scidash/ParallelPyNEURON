

FROM scidash/neuronunit-optimization
RUN git clone -b dev https://github.com/russelljjarvis/informatics_poster.git
WORKDIR informatics_poster/neuronunit/optimization

CMD ipcluster start -n 8 --profile=default &
ENTRYPOINT ipython -i nsga_parallel_no_vm.py


