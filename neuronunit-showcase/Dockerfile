#author Russell Jarvis rjjarvis@asu.edu
#author Rick Gerkin rgerkin@asu.edu

FROM scidash/neuronunit

#Install channelworm
RUN pip install django
RUN git clone https://github.com/russelljjarvis/ChannelWorm.git $WORK_HOME/ChannelWorm
ENV PYTHONPATH $PYTHONPATH:$WORK_HOME/ChannelWorm
RUN python -c "import channelworm"

#Install NeuroConstruct
RUN git clone https://github.com/NeuralEnsemble/neuroConstruct.git $WORK_HOME/neuroConstruct
WORKDIR $WORK_HOME/neuroConstruct
RUN bash nC.sh -make
RUN bash nCenv.sh
RUN echo 'export NC_HOME=$WORK_HOME/neuroConstruct' >> ~/.bashrc
ENV PYTHONPATH $PYTHONPATH:$WORK_HOME/neuroConstruct
RUN python -c "import pythonnC" 
RUN echo 'export NEURON_HOME=/home/jovyan/neuron/nrn-7.4/x86_64' >> ~/.bashrc

#Uncomment the following two lines if you don't want to log in to the docker image interactively.
WORKDIR /home/mnt
#ENTRYPOINT python -i /home/jovyan/mnt/sciunitopt/AIBS.py 