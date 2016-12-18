## Support for graphical development inside docker image (if you can't merge with vimdiff).


Docker image internal support for graphical browser (`iceweasel`), graphical git merge (`meld`), and code editor (`atom` and `gedit`). Notebook doesn't work in the browser yet.

## For an Ubuntu host:
This works very easily.
launching: 
I have defined the alias in my `~/.bashrc`:
`drh` (Docker Run Here):

```
alias drh=' sudo docker run -it -e DISPLAY=$DISPLAY -v `pwd`:/home/mnt \
                                                    -v /tmp/.X11-unix:/tmp/.X11-unix \
                                                    -v /dev/shm:/dev/shm \
                                                    -v ${HOME}/.atom:/home/atom/.atom \
                                                    deapscoop1 /bin/bash'
```
The alias probably should instead be function that is able to accept arguments also.

## For an Apple/MAC host

OSX doesn't have a default x11 server so you must install quartz.

https://fredrikaverpil.github.io/2016/07/31/docker-for-mac-and-gui-applications/

This works because you are mounting the volume associated with your hosts.X11 server binary,  and passing in your hosts environmental variable. I anticipate a future when the drh command will become very long.

The next step is to build this outside of and on-top of docker-stacks images using docker-compose, and also getting docker compose to fill out my github credentials.
