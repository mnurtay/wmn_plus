import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:wmn_plus/features/consultation/bloc/bloc.dart';
import 'package:wmn_plus/features/consultation/model/Chat.dart';

class ChatData extends StatefulWidget {
  final WebSocketChannel channel;
  ChatData({@required this.channel});

  @override
  _ChatDataState createState() => _ChatDataState();
}

class _ChatDataState extends State<ChatData> {
  ChatBloc chatBloc;
  ScrollController scrollController = ScrollController();
  String oldData = '';
  List<Chat> _messages = [];

  @override
  void initState() {
    chatBloc = ChatBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.channel.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != oldData) {
          oldData = snapshot.data;
          chatBloc
              .add(ChatConfig(chatHistory: _messages, newData: snapshot.data));
        }
        return blocListerner(context);
      },
    );
  }

  Widget blocListerner(BuildContext context) {
    return BlocListener(
      bloc: chatBloc,
      listener: (BuildContext context, ChatState state) {
        if (state is FetchedChatState) {
          setState(() {
            _messages = state.messages;
          });
        }
      },
      child: messages(context),
    );
  }

  Widget messages(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(20),
          horizontal: ScreenUtil().setWidth(20)),
      controller: scrollController,
      itemCount: _messages.length,
      reverse: true,
      itemBuilder: (context, index) {
        return message(context, _messages[index]);
      },
    );
  }

  Widget message(BuildContext context, Chat chat) {
    final textStyle = TextStyle(
        color: chat.sendByMe ? Colors.white : Colors.black,
        fontSize: ScreenUtil().setSp(45),
        fontWeight: FontWeight.w400);
    return Container(
      alignment: chat.sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(5),
          horizontal: ScreenUtil().setWidth(10)),
      child: Column(
        crossAxisAlignment:
            chat.sendByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          // --- MESSAGE
          Container(
            decoration: BoxDecoration(
              color: chat.sendByMe ? Color(0xFF7B68EE) : Color(0xFFD3D3D3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ScreenUtil().setSp(35)),
                topRight: Radius.circular(ScreenUtil().setSp(30)),
                bottomLeft: chat.sendByMe
                    ? Radius.circular(ScreenUtil().setSp(35))
                    : Radius.zero,
                bottomRight: chat.sendByMe
                    ? Radius.zero
                    : Radius.circular(ScreenUtil().setSp(35)),
              ),
            ),
            constraints: BoxConstraints(maxWidth: ScreenUtil().setWidth(720)),
            padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(25),
                horizontal: ScreenUtil().setWidth(35)),
            child: Text(chat.message, style: textStyle),
          ),
          // --- DATE
          SizedBox(height: ScreenUtil().setHeight(5)),
          Text(chat.time, style: Theme.of(context).textTheme.display2),
        ],
      ),
    );
  }
}
