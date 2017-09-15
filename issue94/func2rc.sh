

function sc(){
    echo $1
    echo `pwd`
    export IPYTHONDIR=$1
    ipcluster start -n 8 --profile=default --workdir=$1 &
    sleep 5
    python stdout_worker.py &
}
