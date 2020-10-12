import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketNet{
  WebSocketChannel _channel = IOWebSocketChannel.connect('ws://192.168.1.5:6767/serveWs');

  factory SocketNet() => _getInstance();
  static SocketNet get instance => _getInstance();
  static SocketNet _instance;

  SocketNet._internal();

  static SocketNet _getInstance() {
    if (_instance == null){
      _instance = SocketNet._internal();
    }
    return _instance;
  }

  WebSocketChannel getWebSocket(){
    return _channel;
  }

}