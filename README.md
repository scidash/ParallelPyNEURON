# A hierarchy of Docker images for using SciDash tools

Purpose: The building of development environments raises an unnecessary technical problem. In many cases even if someone has the technical capacity to build, it does not mean they will have time to do so. In order to remove this barrier to participation we have created some Docker images to allow people to use our tools. Each of these images serves Jupyter notebooks and including a Python scientific computing stack (extended from jupyter/docker-stacks/scipy-notebook), and some combination of NEURON-7.4, scoop, DEAP, sciunit, and neuronunit.

![Docker container hierarchy](https://github.com/scidash/assets/blob/master/mockups/Containerization%20and%20Continuous%20Integration%20Workflow.png)

# Instructions

## 1
[Download and install Docker](https://www.docker.com/community-edition#/download)

## 2 
### Option 1:
`docker pull scidash/<image-name>` where `<image-name>` is one of the sub-directories above (e.g. `neuronunit-showcase`).
### Option 2:
Build the whole SciDash stack from source instead just download the pre-compiled image with
`./build-all`
### Option 3:
Build just one image with:
`./build <image-name>`
This is similar to the usual `docker build` command except that it checks GitHub to see if a newer version of the corresponding SciDash repository is available, and downloads that code, before building the image.  

Run step 3 to confirm the presence of the image, and step 4 to enter the docker container.

## 3
### Option 1:
`docker run -it -p 8887:8888 <image-name>`
Then point your web browser to `localhost:8887` to create a Jupyter notebook where you can explore the tools.  
### Option 2:
`./run <image-name>`
This takes care of the port configuration and also mounts your local `$HOME/Dropbox` directory (if you have one), so you can create or edit persistent notebooks.  You can edit the `run` script to change this to the location of your preferred notebook directory on your local machine.  
### Option 3:
`./run <image-name> bash`
Start a shell in the built image in order to do other things, e.g. install new packages.  

#### The docker image is able to use the same number of CPUs available on the host system see below:
##### http://stackoverflow.com/questions/20123823/how-does-docker-use-cpu-cores-from-its-host-operating-system

#### To mount a directory containing development files inside the docker container using OSX as the base system use:
`docker run -v /Users/<path>:/<container path> ...`
##### Reference: https://docs.docker.com/engine/tutorials/dockervolumes/

## 4
Want to run JupyterHub with one of these images?  
```
sudo apt-get install npm nodejs-legacy
npm install -g configurable-http-proxy
pip install jupyterhub
pip install -U notebook
jupyterhub --generate-config
```
Then put something like this in your `jupyterhub-config.py` file and follow the instructions in the comments, then run `jupyterhub` from the host.  More is required if you want SSL, GitHub authentication, etc.:  
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
Then run `jupyterhub`, visit the indicated URL (e.g. `10.200.11.1:8000`) in your browser, and log in as a system user.  
