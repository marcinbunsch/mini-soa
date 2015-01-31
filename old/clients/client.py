import sys
sys.path.append('gen-py')

from service import Service
from service.constants import *

from thrift import Thrift
from thrift.transport import TSocket
from thrift.transport import TTransport
from thrift.protocol import TBinaryProtocol

from time import sleep

transport = TSocket.TSocket('localhost', 9089)
transport = TTransport.TBufferedTransport(transport)
protocol = TBinaryProtocol.TBinaryProtocol(transport)

auth = Service.Client(protocol)

transport.open()

while True:
  print auth.get(123)
  sleep(5)

