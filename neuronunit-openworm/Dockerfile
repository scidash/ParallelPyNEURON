# author Russell Jarvis rjjarvis@asu.edu
# author Rick Gerkin rgerkin@asu.edu
# neuronunit-showcase

FROM scidash/neuronunit

#################
# Showcase for ChannelWorm (https://github.com/openworm/ChannelWorm), 
# a subproject of Open Worm (http://www.openworm.org/)
#################
WORKDIR $HOME
RUN pip install django
RUN pip install pytest
RUN pip install django-formtools
RUN pip install django-sql-explorer
RUN git clone -b dev https://github.com/openworm/ChannelWorm.git $HOME/ChannelWorm
WORKDIR $HOME/ChannelWorm
RUN python setup.py install
ENV CHANNELWORM_HOME $HOME/ChannelWorm
RUN python -c "import sys, os; \
               sys.path.append(os.environ['CHANNELWORM_HOME']); \
               import channelworm; \
               channelworm.django_setup()"
WORKDIR $WORK_HOME
