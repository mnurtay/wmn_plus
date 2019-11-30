import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_socket_channel/io.dart';
import 'package:wmn_plus/features/consultation/ui/widget/chat_data.dart';
import 'dart:convert';

import 'package:wmn_plus/features/consultation/model/Doctor.dart';

class ChatPage extends StatefulWidget {
  final Doctor doctor;
  ChatPage({@required this.doctor});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final channel = IOWebSocketChannel.connect(
      'ws://194.146.43.98:8080/conversation?token=qwerty&convID=27a3f1a3d555387ab7bf589ca716c295&role=PAT');
  TextEditingController messageController = TextEditingController();
  bool textFieldIsEmpty = true;

  void _sendMessage() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (messageController.text.isNotEmpty) {
      Map object = {
        'status': 'SEND_MESSAGE',
        'from': 'PAT',
        'content': messageController.text
      };
      channel.sink.add(json.encode(object));
      messageController.clear();
    }
    setState(() {
      textFieldIsEmpty = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: appBar(context),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ChatData(channel: channel),
          ),
          bottomBar(context),
        ],
      ),
    );
  }

  Widget bottomBar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(20),
          bottom: ScreenUtil().setHeight(60),
          left: ScreenUtil().setWidth(35),
          right: ScreenUtil().setWidth(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // --- TEXT FIELD
          Expanded(
            child: TextField(
              controller: messageController,
              style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().setSp(50)))),
                filled: true,
                fillColor: Color(0xFFEFEFEF),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(30),
                    vertical: ScreenUtil().setHeight(20)),
                hintText: 'Сообщение',
              ),
              onEditingComplete: _sendMessage,
              autocorrect: false,
              onChanged: (value) {
                setState(() {
                  textFieldIsEmpty = value.isEmpty;
                });
              },
            ),
          ),
          // --- SEND ICON
          RotationTransition(
            turns: AlwaysStoppedAnimation((textFieldIsEmpty ? 0 : -20) / 360),
            child: IconButton(
              icon: Icon(
                Icons.send,
                color: textFieldIsEmpty ? Colors.black : Colors.blue,
                size: ScreenUtil().setSp(70),
              ),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      title: GestureDetector(
        onTap: () => Navigator.pushNamed(context, "/doctor_page",
            arguments: widget.doctor),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Color(0xFFF5F5F5),
              backgroundImage: NetworkImage(widget.doctor.image),
            ),
            SizedBox(width: ScreenUtil().setWidth(30)),
            Text(
              "${widget.doctor.surname} ${widget.doctor.firstName}",
              style: Theme.of(context).textTheme.body1,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    channel.sink.close();
    super.dispose();
  }
}
