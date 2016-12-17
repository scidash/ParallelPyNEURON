#author Russell Jarvis rjjarvis@asu.edu
#author Rick Gerkin rgerkin@asu.edu

FROM scidash/neuronunit
USER ROOT
RUN apt-get install -y iceweisel

RUN python -c "import pyneuroml"

RUN conda install -y pyqt
#RUN conda install -y matplotlib 

RUN mkdir $HOME/work/scidash
ENV WORK_HOME $HOME/work/scidash

RUN git clone -b dev https://github.com/scidash/sciunit.git $WORK_HOME/sciunit
ENV PYTHONPATH=$PYTHONPATH:$WORK_HOME/sciunit
RUN python -c "import sciunit"

RUN git clone -b dev https://github.com/scidash/neuronunit.git $WORK_HOME/neuronunit
ENV PYTHONPATH=$PYTHONPATH:$WORK_HOME/neuronunit
RUN chown -R jovyan $HOME
RUN find /opt/conda ! -user jovyan -print0 | xargs -0 -I {} chown jovyan {}

USER $NB_USER



RUN python -c "import neuronunit"
RUN python -c "from neuronunit.models.reduced import ReducedModel"
RUN python -c "import quantities"
RUN python -c "import neuron"
RUN python -c "import pyneuroml"
RUN nrnivmodl 
RUN python -c "import scoop"
RUN python -c "import deap"
RUN nrniv

#The following are convenience aliases
RUN echo 'alias nb="jupyter-notebook --ip=* --no-browser"' >> ~/.bashrc
RUN echo 'alias mnt="cd /home/mnt"' >> ~/.bashrc
RUN echo 'alias erc="emacs ~/.bashrc"' >> ~/.bashrc
RUN echo 'alias src="source ~/.bashrc"' >> ~/.bashrc
RUN echo 'alias egg="cd /opt/conda/lib/python3.5/site-packages/"' >> ~/.bashrc 
RUN echo 'alias nu="cd /home/jovyan/work/scidash/neuronunit"' >> ~/.bashrc
RUN echo 'alias model="cd /work/scidash/neuronunit/neuronunit/models"' >> ~/.bashrc
RUN echo 'alias sciunit="cd /work/scidash/sciunit"' >> ~/.bashrc
RUN echo 'alias nu="python -c "from neuronunit.models.reduced import ReducedModel""'
