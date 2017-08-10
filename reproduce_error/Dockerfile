FROM scidash/neuronunit-optimization

WORKDIR /home/jovyan/mnt
USER root
RUN sudo chown -R jovyan /opt/conda
USER jovyan
RUN rm -rf /opt/conda/lib/python3.5/site-packages/*allensdk*
RUN pip install --process-dependency-links git+https://github.com/rgerkin/AllenSDK
#RUN git clone -b dev https://github.com/russelljjarvis/informatics_poster.git
COPY /informatics_poster /home/jovyan/mnt/informatics_poster
RUN sudo chown -R jovyan /home/jovyan/mnt/informatics_poster
WORKDIR /home/jovyan/mnt/informatics_poster/neuronunit/optimization
RUN nrnivmodl NeuroML2
ENV QT_QPA_PLATFORM offscreen
ENV PYTHONPATH $PYTHONPATH:/home/jovyan/mnt/informatics_poster/neuronunit/optimization
ENTRYPOINT ipcluster start -n 8 --profile=default & sleep 5 && ipython -i nsga_parallel_no_vm.py

