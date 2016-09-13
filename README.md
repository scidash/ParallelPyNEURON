[![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.12576.png)](http://dx.doi.org/10.5281/zenodo.12576) [![Binder](http://mybinder.org/badge.svg)](http://mybinder.org/repo/ahwillia/PyNeuron-Toolbox)


Russell's note: I don't know what the PyNeuron-Toolbox does, but it looks like someone has helped us automate the building of NEURON+Python+MPI



I have added a build of open-mpi, miniconda2, and proper config for paran

To run try:

sudo docker build -t para-nrn-python .
docker images
#docker run -it ubuntu:latest /bin/bash
docker run -it para-nrn-python:latest /bin/bash