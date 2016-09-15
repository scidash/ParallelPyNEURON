
## A script to build open-mpi, NEURON-7.4, miniconda python3, all working togethor.

Soon I will add neuronunit/sciunit and JNeuroML

## To build try navigate to this directory (oh wait your here) and try:

sudo docker build -t para-nrn-python .

## To confirm build made an image:
docker images

## To launch the built ubuntu image try:
docker run -it para-nrn-python:latest /bin/bash