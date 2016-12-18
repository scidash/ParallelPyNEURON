#author Russell Jarvis rjjarvis@asu.edu
#author Rick Gerkin rgerkin@asu.edu
FROM scidash/neuronunit
USER root

RUN apt-get update
#Install a browser to run notebooks, meld to facilitate graphical git merging, gvsfs an atom browser dependency.
RUN apt-get install -y iceweasel gedit meld gvfs-bin

RUN wget https://atom.io/download/deb -O atom.deb
RUN dpkg -i atom.deb
RUN python -c "import pyneuroml"



ENV WORK_HOME $HOME/work/scidash

RUN chown -R jovyan $HOME
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
RUN echo 'alias nb="jupyter-notebook'


RUN echo 'alias mnt="cd /home/mnt"' >> ~/.bashrc
RUN echo 'alias erc="emacs ~/.bashrc"' >> ~/.bashrc
RUN echo 'alias src="source ~/.bashrc"' >> ~/.bashrc
RUN echo 'alias egg="cd /opt/conda/lib/python3.5/site-packages/"' >> ~/.bashrc 
RUN echo 'alias nu="cd /home/jovyan/work/scidash/neuronunit"' >> ~/.bashrc
RUN echo 'alias model="cd /work/scidash/neuronunit/neuronunit/models"' >> ~/.bashrc
RUN echo 'alias sciunit="cd /work/scidash/sciunit"' >> ~/.bashrc
RUN echo 'alias nu="python -c "from neuronunit.models.reduced import ReducedModel""'
