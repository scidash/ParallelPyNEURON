# A hierarchy of Docker images for using SciDash tools

Purpose: The building of development environments raises an unnecessary technical problem. In many cases even if someone has the technical capacity to build, it does not mean they will have time to do so. In order to remove this barrier to participation we have created some Docker images to allow people to use our tools. Each of these images serves Jupyter notebooks and including a Python scientific computing stack (extended from jupyter/docker-stacks/scipy-notebook), and some combination of NEURON-7.4, scoop, DEAP, sciunit, and neuronunit.

![Docker container hierarchy](https://github.com/scidash/assets/blob/master/mockups/Containerization%20and%20Continuous%20Integration%20Workflow.png)

# Instructions

## 1
[Download and install Docker](https://www.docker.com/community-edition#/download)

## 2 
- Clone or download this repository:
`git clone https://github.com/scidash/docker-stacks`
- Execute the run script with the name of the image you want to run. 
It may first spend some time downloading the image.  
`./run neuronunit`
- Go to http://localhost:8887 in your web browser.
- Create your own notebook that can import and run the tools installed in the container, or
- Run documentation notebooks in the \*docs folder

### Optional Steps:
- Optionally set the environment variable NOTEBOOK_HOME to the directory that you want to be accessible from within the container.  The default is to use your HOME directory.  
- Optionally change the HOST_PORT in the script from 8887 to some other available port.  
- Instead of using the included scripts you can do the usual `docker pull scidash/<image-name>` where `<image-name>` is one of the sub-directories above (e.g. `neuronunit`).  Then do `docker run -it -p 8887:8888 scidash/<image-name>` to launch it.  
- `./shell <image-name>` to get a shell inside the given container.  
- Rebuild the whole SciDash stack from source instead just download the pre-compiled image with
`./build-all` or build just one image with:
`./build <image-name>`. This is similar to the usual `docker build` command except that it checks GitHub to see if a newer version of the corresponding SciDash repository is available, and downloads that code, before building the image.  
- Optionally set the environment variable SCIDASH_HOME to the location of your sciunit and neuronunit working copies, which will be mounted in the container to override the installed versions when the `-dev` flag is passed to `run` or `shell`.
- The docker image is able to use the same number of CPUs available on the host system see below, so dont' forget to [change your Docker settings](http://stackoverflow.com/questions/20123823/how-does-docker-use-cpu-cores-from-its-host-operating-system) if you want to use the maximum number of CPUs or more memory inside the container.

### Want to run JupyterHub with one of these images?  
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

Ipython Parallel seems to benefit from tini

https://github.com/krallin/tini

NOTE: If you are using Docker 1.13 or greater, Tini is included in Docker itself. This includes all versions of Docker CE. To enable Tini, just pass the --init flag to docker run.

Why tini? (init backwards)

Using Tini has several benefits:

It protects you from software that accidentally creates zombie processes, which can (over time!) starve your entire system for PIDs (and make it unusable).
It ensures that the default signal handlers work for the software you run in your Docker image. For example, with Tini, SIGTERM properly terminates your process even if you didn't explicitly install a signal handler for it.
It does so completely transparently! Docker images that work without Tini will work with Tini without any changes.
If you'd like more detail on why this is useful, review this issue discussion: What is advantage of Tini?.

