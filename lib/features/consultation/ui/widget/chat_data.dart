import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatData extends StatefulWidget {
  final WebSocketChannel channel;
  ChatData({@required this.channel});

  @override
  _ChatDataState createState() => _ChatDataState();
}

class _ChatDataState extends State<ChatData> {
  ScrollController scrollController = ScrollController();
  List<Map> _message = [
    {'from': 'doctor', 'message': 'Lorem', 'date': '18:25'},
    {'from': 'me', 'message': 'Lorem ipsum', 'date': '18:25'},
    {
      'from': 'doctor',
      'message':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit Hello!',
      'date': '18:23'
    },
    {
      'from': 'me',
      'message':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit Hello Doctor!',
      'date': '18:24'
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.channel.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('DATA: ${snapshot.data}');
        }
        return messages(context);
      },
    );
  }

  Widget messages(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(20),
          horizontal: ScreenUtil().setWidth(20)),
      controller: scrollController,
      itemCount: _message.length,
      reverse: true,
      itemBuilder: (context, index) {
        if (_message[index]['from'] == 'me')
          return message(context, index, true);
        else
          return message(context, index, false);
      },
    );
  }

  Widget message(BuildContext context, int index, bool isMine) {
    final textStyle = TextStyle(
        color: isMine ? Colors.white : Colors.black,
        fontSize: ScreenUtil().setSp(45),
        fontWeight: FontWeight.w400);
    return Container(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(5),
          horizontal: ScreenUtil().setWidth(10)),
      child: Column(
        crossAxisAlignment:
            isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          // --- MESSAGE
          Container(
            decoration: BoxDecoration(
              color: isMine ? Color(0xFF7B68EE) : Color(0xFFD3D3D3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ScreenUtil().setSp(35)),
                topRight: Radius.circular(ScreenUtil().setSp(30)),
                bottomLeft: isMine
                    ? Radius.circular(ScreenUtil().setSp(35))
                    : Radius.zero,
                bottomRight: isMine
                    ? Radius.zero
                    : Radius.circular(ScreenUtil().setSp(35)),
              ),
            ),
            constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(720)),
            padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(25),
                horizontal: ScreenUtil().setWidth(35)),
            child: Text(_message[index]['message'], style: textStyle),
          ),
          // --- DATE
          SizedBox(height: ScreenUtil().setHeight(5)),
          Text(_message[index]['date'],
              style: Theme.of(context).textTheme.display2),
        ],
      ),
    );
  }
}
