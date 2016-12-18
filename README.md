

### A hierarchy of Docker images with Jupyter notebooks, a typical Python scientific computing stack, NEURON-7.4, scoop, DEAP, sciunit, and neuronunit.

## Support for graphical development ipython notebook.

Docker image internal support for graphical browser (`chromium/iceweasel`), graphical git merge (`meld`), and code editor (`atom` and `gedit`). 


## For an Ubuntu host:
This works very easily.
launching: 
I have defined the alias in my `~/.bashrc`:
`drh` (Docker Run Here):

```
alias drh=' sudo docker run -it -e DISPLAY=$DISPLAY -v `pwd`:/home/mnt \
                                                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                                                    deapscoop1 /bin/bash'
```
# After building and running the Dockerfile

1 launch jupyter notebook. 
2 Send it to the background with control-c
3 launch a chromium or iceweasel
4 navigate to `URL: http://localhost:8888/tree`

## For an Apple/MAC host

OSX doesn't have a default x11 server so you must install quartz.

https://fredrikaverpil.github.io/2016/07/31/docker-for-mac-and-gui-applications/

This works because you are mounting the volume associated with your hosts.X11 server binary,  and passing in your hosts environmental variable. I anticipate a future when the drh command will become very long.

The next step is to build this outside of and on-top of docker-stacks images using docker-compose, and also getting docker compose to fill out my github credentials.

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
