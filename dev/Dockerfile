FROM scidash/neuronunit-optimization
COPY stdout_worker.py $HOME/stdout_worker.py
COPY func2rc.sh $HOME/func2rc.sh
RUN cat $HOME/func2rc.sh >> ~/.bashrc
RUN sudo chown -R jovyan /home/jovyan/work
ENV QT_QPA_PLATFORM offscreen
ENV PYTHONPATH $PYTHONPATH/home/jovyan/neuronunit/neuronunit/optimization
RUN /bin/bash -c "source $HOME/func2rc.sh"
WORKDIR $HOME/neuronunit/neuronunit
RUN sudo /opt/conda/bin/pip install dask



RUN sudo rm -r $HOME/work
RUN sudo rm -r /opt/conda/lib/python3.5/site-packages/neuronunit*