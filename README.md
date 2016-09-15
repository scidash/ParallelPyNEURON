

# A script to build open-mpi, NEURON-7.4, miniconda python3 all working togethor

Purpose: I am trying to arrange that no one I am personally friends with has to do this ugly and non edifying work ever again.

# TODO: add neuronunit/sciunit and JNeuroML

# 1 get docker 
# 2 After running gitclone navigate to the directory containing this file and run

sudo docker build -t para-nrn-python .

#3 To confirm build made an image:
docker images

#4 To launch the built ubuntu image try:
docker run -it para-nrn-python:latest /bin/bash