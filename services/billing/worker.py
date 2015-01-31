import sys, glob
sys.path.append('gen-py')
# sys.path.insert(0, glob.glob('../../lib/py/build/lib.*')[0])

from billing import Server
from billing.ttypes import *

from thrift.transport import TSocket
from thrift.transport import TTransport
from thrift.protocol import TBinaryProtocol
from thrift.server import TServer

class Handler:

  def isPremiumUser(self, user_id):
    if user_id % 2 == 0:
      return True
    else:
      return False

  def makePremiumUser(self, user_id):
    return True

  def makeRegularUser(self, user_id):
    return True

handler = Handler()
processor = Server.Processor(handler)
transport = TSocket.TServerSocket(host='0.0.0.0', port=9070)
tfactory = TTransport.TBufferedTransportFactory()
pfactory = TBinaryProtocol.TBinaryProtocolFactory()

server = TServer.TThreadPoolServer(processor, transport, tfactory, pfactory)

print 'Starting the Billing::Server at 9070'
server.serve()
print 'done.'

