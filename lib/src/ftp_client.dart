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
      switch(cmd.trim()){
        case "USER":
          response = _setUsername(arguments);
          break;
        case "PASS":
          response = _setPassword(arguments);
          break;
        case "CWD":
          response = _changeWorkingDirectory(arguments);
          break;
        case "CDUP":
          response = _changeWorkingDirectory("..");
          break;
        case "QUIT":
        response = "221 Service closing control connection";
        break;
        case "TYPE":
          List<String> splitArgs = arguments.split(' ');
          response = _type(splitArgs[0], splitArgs.length > 1 ? splitArgs[1] : null);
          break;
        default:
          print("502 $cmd");
          response = "502 Command not implemented";
          break;
      }
    }

    // TODO: send response to client
  }

  String _setUsername(String username){
    _username = username;
    print("Username Setted: $username");
    return "331 Username ok, need password";
  }

  String _setPassword(String password){
    if(true){
      return "230 User logged in";
    }else{
      return "530 Not logged in";
    }
  }

  String _changeWorkingDirectory(String pathName){
    // TODO: Complete the method.
    return "250 Changed to new directory";
  }

  String _type(String typeCode, String formatControl)
  {
    String response = "";

    switch (typeCode.trim())
    {
        case "A":
        case "I":
          _transferType = typeCode;
          response = "200 OK";
          break;
        case "E":
        case "L":
        default:
            response = "504 Command not implemented for that parameter.";
            break;
    }

    if (formatControl != null)
    {
        switch (formatControl)
        {
            case "N":
                response = "200 OK";
                break;
            case "T":
            case "C":
            default:
                response = "504 Command not implemented for that parameter.";
                break;
        }
    }

    return response;
  }


}