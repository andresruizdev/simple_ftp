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

    _socket.listen((List<int> data) => _dataReceiver(data));
    //_socket.listen((List<int> data) { _data })
  }

  _dataReceiver(List<int> data){
    String response = null;
    String result = String.fromCharCodes(data);

    List<String> command = result.split(' ');

    String cmd = command[0].toUpperCase();
    String arguments = command.length > 1 ? result.substring(command[0].length + 1) : null;

    if(arguments == null || arguments.isEmpty)
      arguments = null;

    print("Command: ${command.toString()}");

    if(response == null){
      //TODO: Commands switch
    }

    // TODO: send response to client
  }
}