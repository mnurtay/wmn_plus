import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_socket_channel/io.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  TextEditingController searchController = TextEditingController();
  final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(50)),
              searchWidget(context),
              SizedBox(height: ScreenUtil().setHeight(50)),
              chatList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget chatList(BuildContext context) {
    return StreamBuilder(
      stream: channel.stream,
      builder: (context, snapshot) {
        return Column(
          children: <Widget>[
            chatItem(context, isNewMess: true),
            chatItem(context)
          ],
        );
      },
    );
  }

  Widget chatItem(BuildContext context, {bool isNewMess = false}) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/chat_page'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.all(Radius.circular(ScreenUtil().setSp(30))),
        ),
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(30),
            horizontal: ScreenUtil().setWidth(30)),
        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- DOCTOR IMAGE
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(ScreenUtil().setSp(40))),
                  color: Color(0xFFF5F5F5),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://hcplive.s3.amazonaws.com/v1_media/_image/happydoctor.jpg'),
                      fit: BoxFit.cover)),
            ),
            // --- CHAT INFORMATION
            SizedBox(width: ScreenUtil().setWidth(35)),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Dr. Gary Hawkins',
                            style: Theme.of(context).textTheme.body2,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        isNewMess
                            ? Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.red),
                                child: Center(
                                  child: Text('3',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              )
                            : Text('10.05.2019',
                                style: Theme.of(context).textTheme.display2),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Text(
                      'You: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.display2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchWidget(BuildContext context) {
    InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(60))),
      borderSide: BorderSide(color: Colors.grey),
    );
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        border: inputBorder,
        focusedBorder: inputBorder,
        contentPadding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(30),
          horizontal: ScreenUtil().setWidth(30),
        ),
        prefixIcon: Icon(Icons.search, color: Colors.black),
        filled: true,
        fillColor: Color(0xFFF5F5F5),
        hintText: 'Поиск',
      ),
      autocorrect: false,
      style: Theme.of(context).textTheme.body1,
    );
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      title: Text('Консультация', style: Theme.of(context).textTheme.title),
      backgroundColor: Colors.white,
      centerTitle: false,
      elevation: 0,
      actions: <Widget>[
        Container(
          padding: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/new_consultation'),
            child: Icon(
              Icons.add,
              size: ScreenUtil().setSp(80),
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
