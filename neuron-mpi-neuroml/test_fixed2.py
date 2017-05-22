#import mpi4py
#from mpi4py import MPI

import ipyparallel as ipp ;
rc = ipp.Client(profile='chase');
print('hello from before cpu ');
print(rc.ids);

from neuron import h
pc = h.ParallelContext()
#pc0 = MPI.COMM.Rank()
id = int(pc.id())
nhost = int(pc.nhost())

print('I am a demonstration that NEURONs parallel context and ipyparallel are compossible, by showing the rank read outs are equal/same:')
print('%d of %d' %(id, nhost))#, pc0))

print(int(rc.ids[id]))

pc.runworker()
pc.done()
h.quit()
