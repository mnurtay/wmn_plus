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
      appBar: PreferredSize(
        preferredSize: Size(null, ScreenUtil().setHeight(120)),
        child: appBar(context),
      ),
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
        return chatItem(context);
      },
    );
  }

  Widget chatItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: ScreenUtil().width,
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  // --- DOCTOR AVATAR
                  CircleAvatar(
                    radius: ScreenUtil().setSp(80),
                    backgroundImage: NetworkImage(
                        'https://cdn.aarp.net/content/dam/aarp/health/healthy-living/2017/08/1140-pick-the-right-surgeon-promo.imgcache.rev25509302e5ccf4c77f0aa07ae207d363.jpg'),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(30)),
                  // --- DOCTOR NAME AND LAST MESSAGE
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Jeff Washington',
                          style: Theme.of(context).textTheme.body2),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      Text('Jeff Washington',
                          maxLines: 2,
                          style: Theme.of(context).textTheme.display2),
                    ],
                  )
                ],
              ),
              // --- NEW MESSAGE COUNT
              Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                decoration:
                    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                child: Center(
                  child: Text('3',
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey)
      ],
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(ScreenUtil().setSp(75)),
          bottomRight: Radius.circular(ScreenUtil().setSp(75)),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: ScreenUtil().setHeight(60)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Консультация', style: Theme.of(context).textTheme.title),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/new_consultation'),
                child: Icon(Icons.add, size: ScreenUtil().setSp(75)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
