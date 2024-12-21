import 'dart:async';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../config/env.dart';

class SocketService {
  static late IO.Socket socket;
  static late StreamController<Map<String, dynamic>>
      onMessageSendStreamController;
  static late StreamController<Map<String, dynamic>> onMessageReceiveController;
  static late StreamController<Map<String, dynamic>>
      onChatImageReceiveController;

  static init() {
    onMessageSendStreamController =
        StreamController<Map<String, dynamic>>.broadcast();
    onMessageReceiveController =
        StreamController<Map<String, dynamic>>.broadcast();
    onChatImageReceiveController =
        StreamController<Map<String, dynamic>>.broadcast();

    try {
      socket = IO.io(
        BASE_SOCKET_API_URL,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'autoConnect': false}) // disable auto-connection
            .build(),
      )..connect();
      socket.onConnect((_) {
        print('Socket connected!');
      });

      socket.onDisconnect((data) {});
      socket.onConnectError((err) => print(err));
      socket.onError((err) => print(err));
      socket.on('your_message', (data) {
        ///my message here...
      });
      socket.on('receive_message', (data) {
        /// received message here...
        onMessageReceiveController.sink.add(data);
      });
      socket.on('chatImage', (data) {
        /// image will be here...
        onChatImageReceiveController.sink.add(data);
      });
    } catch (e) {
      print(e);
    }
  }

  /// events
  void sendMessage({
    required String data,
  }) {
    socket.emit(
      'send_message',
      jsonEncode({
        ///send messages here....
      }),
    );
  }

  void chatImage({
    required String imageFile,
  }) {
    socket.emit(
      'chatImage',
      jsonEncode({
        ///image will be send from here
      }),
    );
  }
}
