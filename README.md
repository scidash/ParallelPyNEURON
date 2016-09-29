

# A script to build open-mpi, NEURON-7.4, miniconda python3 all working togethor

Purpose: The building of development environments raises an unnecessary technical problem. In many cases even if someone has the technical capacity to build, it does not mean they will have time too. In order to remove this barrier to participation I have attempted to create a docker image. The docker image builds open-mpi, NEURON-7.4 and miniconda python3 such that they all working together.

neuronunit/sciunit dev branches have also been added

# 1
Get docker 

# 2 The easy way inline with philosophy stated above don't build the docker image from source instead just download the pre-compiled image with
docker pull russelljarvis/pyneuron-toolbox 

Run step 3 to confirm the presence of the image, and step 4 to enter the docker container.

It may even be possible to to use the container non interactively, by passing commands to it with -c



# 2 The long way:
Assuming you have git, after running git clone navigate to the directory containing this file and run

sudo docker build -t para-nrn-python .

This tells docker to build an image based on the contents of the file labelled Dockerfile located in the present working directory. The image that is output from this process is not actually output to this directory. The image is accessible in any directory visible to the shell in an instance of the docker daemon.

# 3
To confirm build made an image:
docker images

# 4
To enter the built ubuntu image try:
docker run -it para-nrn-python:latest /bin/bash

