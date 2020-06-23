import 'dart:async';
import 'dart:io';

class FtpServer{
  String _ipAddress;
  int _port;
  ServerSocket _serverSocket;
  Socket _socket;

  FtpServer(){
    _ipAddress = "0.0.0.0";;
    _port = 21;

    start();
  }

  FtpServer.createServer(ipAddress, port){
    this._ipAddress = ipAddress;
    this._port = port;

    start();
  }

  start() async {
    _serverSocket = await createServerSocket();
    _serverSocket.listen((Socket socket) => _serverListener(socket));
  }

  Future<ServerSocket> createServerSocket() async {
    Future<ServerSocket> _server = ServerSocket.bind(_ipAddress, _port);
    _server.then((ServerSocket server) {
      //_serverSocket = server;
      return _server;
    });
  }

  stop(){
    if(_serverSocket != null){
      _serverSocket.close();
    }
  }

  _serverListener(Socket socket){
    _socket = socket;
    _socket.write("Flutter FTP Server Plugin");
    _socket.listen((List<int> data) => _dataReceiver(data));

  }

  _dataReceiver(List<int> data){
    String result = new String.fromCharCodes(data);
    print(result.toString());
  }


}