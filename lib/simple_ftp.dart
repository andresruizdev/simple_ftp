library simple_ftp;

import 'package:simple_ftp/src/ftp_server.dart';
export 'package:simple_ftp/simple_ftp.dart';
/// A Calculator.
class SimpleFTP{
  FtpServer _ftpServer;

  SimpleFTP(){
    _ftpServer = new FtpServer();
  }
}
