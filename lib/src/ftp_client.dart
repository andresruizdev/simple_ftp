import 'dart:convert';
import 'dart:html';
import 'dart:io';

class FtpClient{
  Socket _socket;
  String _address;
  int _port;
  String _username;
  String _transferType;

  FtpClient(Socket socket){
    _socket = socket;
    _address = _socket.remoteAddress.address;
    _port = _socket.remotePort;

    _socket.writeln("220 Ready!");
    _socket.flush();
    //_socket.listen((List<int> data) { _data })
  }

}