FROM neuron_mpi_neuroml

USER root

RUN pip install git+https://github.com/rgerkin/rickpy
RUN pip install git+https://github.com/scidash/neuronunit@dev --process-dependency-links
RUN pip install git+https://github.com/soravux/scoop
RUN pip install git+https://github.com/DEAP/deap
	
USER $NB_USER

RUN nrniv
RUN mpiexec -np 4 python -c "import mpi4py"
RUN python -c "import neuron; import sciunit; import neuronunit"
RUN nrnivmodl 
RUN echo "that last stderr may have looked bad, but it was probably an indication that nrnivmodl can work if given mod files"
RUN python -c "import scoop; import deap"