FROM scidash/neuronunit-optimization

WORKDIR /home/jovyan/mnt
USER root
RUN sudo chown -R jovyan /opt/conda
USER jovyan
RUN rm -rf /opt/conda/lib/python3.5/site-packages/*allensdk*
RUN pip install --process-dependency-links git+https://github.com/rgerkin/AllenSDK
#RUN git clone -b dev https://github.com/russelljjarvis/informatics_poster.git

RUN sudo chown -R jovyan /home/jovyan/mnt

#WORKDIR /home/jovyan/mnt
#RUN git clone -b issue94 https://github.com/scidash/neuronunit.git

#This is informed by Rick's actual code:


COPY neuronunit /home/jovyan/mnt/neuronunit


WORKDIR /home/jovyan/mnt/neuronunit/neuronunit/optimization/NeuroML2
RUN sudo chown -R jovyan /home/jovyan/mnt

RUN nrnivmodl
WORKDIR /home/jovyan/mnt/neuronunit/neuronunit/optimization
ENV QT_QPA_PLATFORM offscreen
ENV PYTHONPATH $PYTHONPATH:/home/jovyan/mnt/neuronunit/neuronunit/optimization
ENTRYPOINT ipcluster start -n 8 --profile=default & sleep 5 & /bin/bash





