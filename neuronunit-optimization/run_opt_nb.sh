docker run -p 8888:8888 -v `pwd`:/home/jovyan/mnt scidash/neuronunit-optimization jupyter notebook --ip=0.0.0.0 --NotebookApp.token=\"\" --NotebookApp.disable_check_xsrf=True 
