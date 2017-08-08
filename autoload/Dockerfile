###
## A file that is expected to be available after a volume is mounted
## cannot by executed using the entrypoint command, since
## Entry point acts on files that do exist
## Instead write a BASH script
## That merely assumes this path will
## become available at start up
## and execute it from its expected path on the mounted volume
## After building this file I launch docker with the alias al
## docker build autoload -t scidash/autoload
## alias al='cd ~/scratch;sudo docker run -e DISPLAY=$DISPLAY -it -v `pwd`:/home/mnt -v ${HOME}/git/.git \
##                                                                        -v /tmp/.X11-unix:/tmp/.X11-unix \
##                                                    scidash/autoload'
###
FROM scidash/neuronunit-optimization
RUN sudo /opt/conda/bin/pip install cufflinks
RUN touch start.sh
RUN echo "cd /home/mnt/neuronunit/neuronunit/optimization" >> start.sh
RUN echo "ipcluster start -n 8 --profile=default & sleep 5 && ipython -i nsga_parallel.py" >> start.sh
ENTRYPOINT /bin/bash start.sh
