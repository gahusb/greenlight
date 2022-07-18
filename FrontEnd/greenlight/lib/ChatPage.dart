import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}
class ChatPage extends StatelessWidget {
  final url = "wss://demo.piesocket.com/v3/channel_124124?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(
        channel: IOWebSocketChannel.connect(url), // (wss:// ... )  -> webSocket test page
        key: UniqueKey(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final WebSocketChannel channel;

  MyHomePage({required Key key, required this.channel})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
      firstName: 'User A');
  // TODO : id/nickname 수정 필요

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      body:
            StreamBuilder(
              stream: widget.channel.stream,
              builder: (context,AsyncSnapshot snapshot) {
                _decodeSnapshot(snapshot);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Chat(
                    showUserNames: true,
                    messages: _messages,
                    onSendPressed: _handleSendPressed,
                    user: _user,
                  ),
                );
              },
            ),
    );
  }
  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _sendMessage(textMessage);
  }
  void _decodeSnapshot(AsyncSnapshot message) {
    if (message.hasData) {
      final json = jsonDecode(message.data);

      var textMessage = types.TextMessage(
        author: types.User(id: json['author']['id']
            ,firstName: json['author']['firstName']),
        createdAt: json['createdAt'],
        id: json['id'],
        text: json['text'],
      );
      _addMessage(textMessage);
    }
  }

  void _addMessage(types.Message message) {
      _messages.insert(0, message);
  }

  void _sendMessage(types.Message message) {
    widget.channel.sink.add(jsonEncode(message));
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}