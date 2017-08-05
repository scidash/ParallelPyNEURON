

FROM scidash/neuronunit-optimization
RUN git clone -b dev https://github.com/russelljjarvis/informatics_poster.git
WORKDIR informatics_poster/neuronunit/optimization

ENTRYPOINT ipython -i -c "import os,time;os.system('ipcluster start -n 8 --profile=default');time.sleep(4);import nsga_parallel_no_vm"


