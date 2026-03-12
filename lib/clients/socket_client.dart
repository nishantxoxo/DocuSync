



import 'package:docu_sync/constants.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketClient {
  Socket? socket;
  static SocketClient? _inst;


  SocketClient._internal(){
    socket = io(host, <String, dynamic> {
      'transports' : ['websocket'],
      'autoConnect' : false,
    });

    socket!.connect();
  }


    static SocketClient get instance {
      _inst??=SocketClient._internal();
      return _inst!;

    }
}