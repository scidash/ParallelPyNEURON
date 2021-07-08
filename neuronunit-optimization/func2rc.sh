

function sc(){
    export PYTHONPATH=$1
    ipcluster start -n 8 --profile=default &
    sleep 5
    python stdout_worker.py &
    ipython -i nsga_parallel.py
    # explanation
    # there is some ugly inconsistencies between the
    # controller and the engines on ipyparallel
    # basically the controllers fixed location of neuronunit is fixed to /home/jovyan/work/neuronunit/neuronunit
    # this probably
    # because PYTHONPATH was set to this early with ENV
    # this is very static and it can't be updated
    #ln -s "`$1`../../neuronunit  /home/jovyan/work/neuronunit/neuronunit"
}

