import 'dart:async';
import 'dart:io';

import 'package:simple_ftp/src/ftp_client.dart';

class FtpServer{
  String _ipAddress;
  int _port;
  ServerSocket _serverSocket;
  List<FtpClient> clients = [];

  FtpServer(){
    _ipAddress = '0.0.0.0';
    _port = 21;

    start();
  }

  FtpServer.createServer(ipAddress, port){
    this._ipAddress = ipAddress;
    this._port = port;

    start();
  }

  start() async {
    Future<ServerSocket> serverFuture = ServerSocket.bind(_ipAddress, _port);
    serverFuture.then((ServerSocket server) {
      _serverSocket = server;
      print("Created Server Socket");
      server.listen((Socket socket) async {
        await Future.delayed(Duration(seconds: 1));
        clients.add(FtpClient(socket));
        /*socket.writeln("Flutter FTP Server");
        socket.flush();*/
        
      });
    });
  }

  stop(){
    if(_serverSocket != null){
      _serverSocket.close();
    }
  }

}