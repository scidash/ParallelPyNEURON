#author Russell Jarvis rjjarvis@asu.edu
#author Rick Gerkin rgerkin@asu.edu

FROM scidash/neuronunit

ENV WORK_HOME $HOME/work

#Install channelworm
RUN pip install django
RUN pip install pytest
RUN pip install django-formtools
RUN pip install django-sql-explorer
RUN git clone -b dev https://github.com/openworm/ChannelWorm.git $WORK_HOME/ChannelWorm
WORKDIR $WORK_HOME/ChannelWorm
RUN python setup.py install
ENV PYTHONPATH $PYTHONPATH:$WORK_HOME/ChannelWorm
WORKDIR $WORK_HOME
RUN python -c "import channelworm"

#Install NeuroConstruct
RUN git clone https://github.com/NeuralEnsemble/neuroConstruct.git $WORK_HOME/neuroConstruct
WORKDIR $WORK_HOME/neuroConstruct
RUN bash nC.sh -make
RUN bash nCenv.sh
RUN echo 'export NC_HOME=$WORK_HOME/neuroConstruct' >> ~/.bashrc
ENV PYTHONPATH $PYTHONPATH:$WORK_HOME/neuroConstruct
RUN python -c "import pythonnC" 
RUN echo 'export NEURON_HOME=$HOME/neuron/nrn-7.4/x86_64' >> ~/.bashrc

WORKDIR /home/jovyan/work
RUN python -c "import channelworm; channelworm.django_setup()"
