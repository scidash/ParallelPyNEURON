

# A script to build open-mpi, NEURON-7.4, miniconda python3 all working togethor

Purpose: The building of development environments raises an unnecessary technical problem. In many cases even if someone has the technical capacity to build, it does not mean they will have time too. In order to remove this barrier to participation I have attempted to create a docker image. The docker image builds open-mpi, NEURON-7.4 and miniconda python3 such that they all working togethor.

Additionally the dockerimage plans to support JNeuroML and neuronunit.



Remove unnecessary obstacles to participation


TODO: add neuronunit/sciunit and JNeuroML

# 1
Get docker 
# 2
After running gitclone navigate to the directory containing this file and run

sudo docker build -t para-nrn-python .

#3
To confirm build made an image:
docker images

#4
To launch the built ubuntu image try:
docker run -it para-nrn-python:latest /bin/bash