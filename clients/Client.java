import org.apache.thrift.TException;
import org.apache.thrift.protocol.TBinaryProtocol;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.transport.TSocket;
import org.apache.thrift.transport.TTransport;
import org.apache.thrift.transport.TTransportException;

public class Client {

 public static void main(String[] args) {

  try {
    TTransport transport;

    transport = new TSocket("localhost", 9089);
    transport.open();

    TProtocol protocol = new TBinaryProtocol(transport);
    Service.Client client = new Service.Client(protocol);

    try {
      while (true) {
        System.out.println(client.get(100));
        Thread.sleep(4000);
      }
    } catch (InterruptedException e) {
      e.printStackTrace();
    }

    transport.close();
  } catch (TTransportException e) {
    e.printStackTrace();
  } catch (TException x) {
    x.printStackTrace();
  }
 }

}
