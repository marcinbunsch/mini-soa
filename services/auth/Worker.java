package services.auth;

import org.apache.thrift.transport.TServerSocket;
import org.apache.thrift.transport.TServerTransport;
import org.apache.thrift.server.TServer;
import org.apache.thrift.server.TServer.Args;
import org.apache.thrift.server.TSimpleServer;
import org.apache.thrift.server.TThreadPoolServer;

import org.apache.thrift.TException;
import auth.User;

class AuthServiceHandler implements auth.Server.Iface {

  @Override
  public User getUserByToken(String token) throws TException {
    return new User();
  }

  @Override
  public User getUserById(int id) throws TException {
    return new User();
  }

  @Override
  public User getUserByEmail(String email) throws TException {
    return new User();
  }
}

public class Worker {

 public static void main(String[] args) {
   AuthServiceHandler handler = new AuthServiceHandler();
   auth.Server.Processor<AuthServiceHandler> processor = new auth.Server.Processor<AuthServiceHandler>(handler);
   try {
     TServerTransport serverTransport = new TServerSocket(9050);
     TServer server = new TThreadPoolServer(
       new TThreadPoolServer.Args(serverTransport).processor(processor));

     System.out.println("Starting the threaded server at 9050");
     server.serve();
   } catch (Exception e) {
     e.printStackTrace();
   }
 }

}

