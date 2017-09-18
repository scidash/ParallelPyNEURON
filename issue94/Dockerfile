FROM scidash/neuronunit-optimization

WORKDIR /home/jovyan/mnt
USER root
RUN sudo chown -R jovyan /opt/conda
USER jovyan
RUN rm -rf /opt/conda/lib/python3.5/site-packages/*allensdk*
RUN pip install --process-dependency-links git+https://github.com/rgerkin/AllenSDK
#RUN git clone -b dev https://github.com/russelljjarvis/informatics_poster.git

RUN sudo chown -R jovyan /home/jovyan/mnt
RUN sudo /opt/conda/bin/pip install psutil

WORKDIR /home/jovyan/work
RUN git clone -b dev https://github.com/rgerkin/informatics_poster.git
RUN cp -r informatics_poster neuronunit
# https://github.com/rgerkin/informatics_poster.git

#This is informed by Rick's actual code:
COPY stdout_worker.py /home/jovyan/work/neuronunit/neuronunit/optimization


#COPY neuronunit /home/jovyan/mnt/neuronunit

#/home/jovyan/work/neuronunit
WORKDIR /home/jovyan/work/neuronunit/neuronunit/optimization
WORKDIR /home/jovyan/work/neuronunit/neuronunit/optimization/NeuroML2
#/neuronunit/optimization/NeuroML2
RUN sudo chown -R jovyan /home/jovyan/mnt

RUN nrnivmodl
#WORKDIR /home/jovyan/mnt/neuronunit/neuronunit/optimization
WORKDIR $HOME/work/special/stable/neuronunit/optimization
ENV QT_QPA_PLATFORM offscreen

ENV PYTHONPATH /home/jovyan/mnt/neuronunit/neuronunit/optimization



COPY func2rc.sh $HOME/func2rc.sh
RUN cat $HOME/func2rc.sh >> $HOME/.bashrc




