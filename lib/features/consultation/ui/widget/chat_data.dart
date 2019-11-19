import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatData extends StatefulWidget {
  final WebSocketChannel channel;
  ChatData({@required this.channel});

  @override
  _ChatDataState createState() => _ChatDataState();
}

class _ChatDataState extends State<ChatData> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.channel.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('DATA: ${snapshot.data}');
        }
        return Container(
          constraints: BoxConstraints(maxWidth: 100),
        );
      },
    );
  }
}
