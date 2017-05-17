# A hierarchy of Docker images with Jupyter notebooks, a typical Python scientific computing stack, NEURON-7.4, scoop, DEAP, sciunit, and neuronunit.

Purpose: The building of development environments raises an unnecessary technical problem. In many cases even if someone has the technical capacity to build, it does not mean they will have time too. In order to remove this barrier to participation we have attempted to create some useful docker images. 

## 1
Get docker 

## 2 
In accordance with the philosophy stated above don't build the docker image from source instead just download the pre-compiled image with
`docker pull scidash/<image-name>`

where `<image-name>` is one of the sub-directories above (e.g. `neuron-mpi-neuroml`)

Run step 3 to confirm the presence of the image, and step 4 to enter the docker container.

## 2 (The long way):
Assuming you have git, after running git clone navigate to the directory containing this file and run

`sudo docker build -t <image-name> .`

This tells docker to build an image based on the contents of the file labelled Dockerfile located in the present working directory. The image that is output from this process is not actually output to this directory. The image is accessible in any directory visible to the shell in an instance of the docker daemon.

## 3
To confirm build made an image:

`docker images`

## 4
To enter the built image try interactively inorder to do neurounit development inside the image use:

`docker run -it <image-name> bash`

## 5
To throw commands at the docker image without actually entering it use syntactic pattern like:

`docker run neuronunit-scoop-deap python -c "import neuron; import neuronunit; import sciunit"`

`docker run neuronunit-scoop-deap nproc`

### The docker image is able to use the same number of CPUs available on the host system see below:
#### http://stackoverflow.com/questions/20123823/how-does-docker-use-cpu-cores-from-its-host-operating-system

### To mount a directory containing development files inside the docker container using OSX as the base system use:
`docker run -v /Users/<path>:/<container path> ...`
##### Reference: https://docs.docker.com/engine/tutorials/dockervolumes/

### To interact with your Jupyter noteboks through these images, do:
`docker run -d -p 8888:8888 -v /path/to/my/notebooks:/Users/jovyan/work/notebooks`
### and then go to localhost:8888 in your web browser.

### To mount a host file system, and then to develop interactively inside the image:

```docker run -it -p 8888:8888 -v `pwd`:/home/jovyan/work/scipyopt <image_name> bash```

Note: Jovyan is a reference to the Greek God Jupyter, however its also an arbitary choice of name for the user space on the docker filesystem. 

# 6
The hierarchy of docker images here is:  
#### neuronunit-scoop-deap
###### depends on
#### neuron-mpi-neuroml
###### depends on
#### scipy-notebook-plus
###### depends on
#### jupyter/scipy-notebook (http://github.com/jupyter/docker-stacks)

Want to run JupyterHub with one of these images?  Put something like this in your `jupyterhub-config.py` file and follow the instructions in the comments.  More is required if you want SSL, GitHub authentication, etc.:  
```python
import os
import platform
import netifaces

# Install the proxy first:
# npm install -g configurable-http-proxy
# If NPM is not working on your Mac, try this:  
# https://gist.github.com/DanHerbert/9520689

c.JupyterHub.spawner_class = 'dockerspawner.DockerSpawner'

# You need to open up a port on the host that a Docker container can access:
# sudo ifconfig lo0 alias 10.200.11.1/24
if platform.system == 'Darwin':
    lo0 = netifaces.ifaddresses('lo0')
    try:
        docker0_ipv4 = lo0[netifaces.AF_INET][1]
    except IndexError:
        raise Exception(("OSX hosts must add an additional IP to the loopback interface that the Docker container can access, "
                         "e.g. 'sudo ifconfig lo0 alias 10.200.10.1/24'"))
else:
    docker0 = netifaces.ifaddresses('docker0')
    docker0_ipv4 = lo0[netifaces.AF_INET][0]
ip = docker0_ipv4['addr']

c.JupyterHub.ip = ip
c.JupyterHub.hub_ip = ip

# If you make changes an restart the server, you might want to kill 
# the Docker container so that it starts a new one instead of using the old one:
# docker rm -f $(docker ps -a -q) # Careful, this kills all the containers. 
c.DockerSpawner.container_image = 'scidash/neuronunit-showcase'
c.DockerSpawner.extra_create_kwargs.update({
    'command': '/usr/local/bin/start-singleuser.sh'
})
```
