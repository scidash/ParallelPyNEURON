sudo /opt/conda/bin/pip install -e ../../neuronunit
ipcluster start -n 8 --profile=default & sleep 25; python stdout_worker.py &
ipython -i ../unit_test/exhaustive_search.py
