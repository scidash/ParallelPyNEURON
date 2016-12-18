#author Russell Jarvis rjjarvis@asu.edu
#author Rick Gerkin rgerkin@asu.edu
FROM scidash/neuronunit
USER root

ENV ATOM_VERSION v1.12.7
RUN apt-get update
RUN apt-get install -y iceweasel gedit meld gvfs-bin 
RUN apt-get install -y curl

RUN curl -L https://github.com/atom/atom/releases/download/${ATOM_VERSION}/atom-amd64.deb > /tmp/atom.deb && dpkg -i /tmp/atom.deb && rm -f /tmp/atom.deb 
   
    
    
#RUN dpkg -i atom.deb
RUN python -c "import pyneuroml"



ENV WORK_HOME $HOME/work/scidash
RUN ipython profile create default
RUN apt-get install libxss1
#RUN apt-get update
#RUN apt-get apt-utils
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
RUN echo 'alias nb="jupyter notebook --browswer iceweasel'

RUN echo 'alias mnt="cd /home/mnt"' >> ~/.bashrc
RUN echo 'alias erc="emacs ~/.bashrc"' >> ~/.bashrc
RUN echo 'alias src="source ~/.bashrc"' >> ~/.bashrc
RUN echo 'alias egg="cd /opt/conda/lib/python3.5/site-packages/"' >> ~/.bashrc 
RUN echo 'alias nu="cd /home/jovyan/work/scidash/neuronunit"' >> ~/.bashrc
RUN echo 'alias model="cd /work/scidash/neuronunit/neuronunit/models"' >> ~/.bashrc
RUN echo 'alias sciunit="cd /work/scidash/sciunit"' >> ~/.bashrc
RUN echo 'alias nu="python -c "from neuronunit.models.reduced import ReducedModel""'
