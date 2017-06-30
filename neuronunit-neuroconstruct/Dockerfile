# author Russell Jarvis rjjarvis@asu.edu
# author Rick Gerkin rgerkin@asu.edu
# neuronunit-showcase

FROM scidash/neuronunit

#################
# Showcase for NeuroConstruct (http://www.neuroconstruct.org/) by Padraig Gleeson, 
# a subproject of Neural Ensemble (http://neuralensemble.org/)
#################
USER root
RUN apt-get update
RUN apt-get install -y subversion
USER $NB_USER
RUN pip install execnet
WORKDIR $HOME
RUN git clone https://github.com/NeuralEnsemble/neuroConstruct.git
WORKDIR neuroConstruct
RUN bash updatenC.sh
RUN bash nC.sh -make
RUN ant run
WORKDIR osb
RUN ./checkOsb.sh
USER root
RUN ln -s $NEURON_HOME/bin/nrnivmodl /usr/local/bin/
USER $NB_USER
WORKDIR $HOME/neuroConstruct
RUN ant test -Dsimulators='NEURON'
ENV NC_HOME $HOME/neuroConstruct
ENV PYTHONPATH $NC_HOME
USER $NB_USER
RUN python -c "import pythonnC" 
WORKDIR $WORK_HOME
