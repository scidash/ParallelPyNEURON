#author Russell Jarvis rjjarvis@asu.edu
#author Rick Gerkin rgerkin@asu.edu
FROM scidash/neuronunit
USER root

ENV ATOM_VERSION v1.12.7
RUN apt-get update
RUN apt-get install -y gedit meld gvfs-bin iceweasel
RUN apt-get install -y curl

RUN curl -L https://github.com/atom/atom/releases/download/${ATOM_VERSION}/atom-amd64.deb > /tmp/atom.deb && dpkg -i /tmp/atom.deb && rm -f /tmp/atom.deb

ENV WORK_HOME $HOME/work/scidash

RUN ipython profile create default

RUN apt-get update && apt-get install -y xvfb chromium
#ADD xvfb-chromium /usr/bin/xvfb-chromium
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browse
RUN apt-get install -y libxss1 
WORKDIR $HOME
RUN git clone https://github.com/ipython/ipyparallel
WORKDIR $HOME/ipyparallel
RUN python3 setup.py install
WORKDIR $HOME
RUN git clone https://github.com/rkern/line_profiler
WORKDIR $HOME/line_profiler
RUN python setup.py install
WORKDIR $WORK_HOME
RUN git clone https://github.com/BlueBrain/BluePyOpt
WORKDIR $WORK_HOME/BluePyOpt
RUN python3 setup.py install
RUN ipcluster nbextension enable

ENV PATH $PATH:/opt/conda/bin
ENV PATH $PATH:/opt/conda/bin/ipython
ENV PATH $PATH:/opt/conda/bin/pip
ENV PATH $PATH:/opt/conda/bin/python

RUN apt-get install -y python3-setuptools
ENV PATH $PATH:/opt/conda/bin

RUN pip install --upgrade pip
RUN apt-get install -y python-matplotlib

RUN easy_install gevent
RUN easy_install greenlet

RUN git clone https://github.com/soravux/scoop
WORKDIR scoop
RUN python setup.py install
RUN chown -R jovyan $HOME

USER $NB_USER

RUN python -c "import pyneuroml"
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
RUN export PATH=$PATH
#RUN sudo ipcluster start
#CMD sudo ipcluster start
