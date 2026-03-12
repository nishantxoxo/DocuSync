import 'package:docu_sync/clients/socket_client.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketRepository {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  void joinRoom(String docid){
    _socketClient.emit('join', docid);
  }


  void typing(Map<String, dynamic> data){
    _socketClient.emit('typing', data);

  }


  void changeListner(Function(Map<String, dynamic> ) funn){
    _socketClient.on('changes', (data) => funn(data));
  }

  void autoSave(Map<String, dynamic> data){
    print("auto saver called" );
    _socketClient.emit('save', data);
  }


}