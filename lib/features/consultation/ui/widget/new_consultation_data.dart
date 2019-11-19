import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/util/config.dart';

class NewConsultationData extends StatefulWidget {
  @override
  _NewConsultationDataState createState() => _NewConsultationDataState();
}

class _NewConsultationDataState extends State<NewConsultationData> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: ScreenUtil().setHeight(20)),
          categoriesContent(context),
          SizedBox(height: ScreenUtil().setHeight(40)),
          // chatsContent(context),
        ],
      ),
    );
  }

  Widget chatsContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text('Консультации', style: Theme.of(context).textTheme.display1),
              // Text('Посмотреть все',
              //     style: Theme.of(context).textTheme.display2),
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(40)),
          chatList(context),
        ],
      ),
    );
  }

  Widget chatList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(30))),
      ),
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(30),
          horizontal: ScreenUtil().setWidth(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // --- DOCTOR IMAGE
          Container(
            width: ScreenUtil().setWidth(200),
            height: ScreenUtil().setHeight(160),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(ScreenUtil().setSp(40))),
                color: Colors.grey,
                image: DecorationImage(
                    image: NetworkImage(
                        'https://static.makeuseof.com/wp-content/uploads/2015/11/perfect-profile-picture-all-about-face.jpg'),
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
                      Text('Dr. Gary Hawkins',
                          style: Theme.of(context).textTheme.body2),
                      Text('10.05.2019',
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
    );
  }

  Widget categoriesContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(30),
              vertical: ScreenUtil().setHeight(30)),
          child: Text('Категории', style: Theme.of(context).textTheme.display1),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(30),
              vertical: ScreenUtil().setHeight(30)),
          child: Column(
            children: DOCTOR_CATEGORIES.map((value) {
              return categoriesList(context, value);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget categoriesList(BuildContext context, String value) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: ScreenUtil().width,
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(40),
            vertical: ScreenUtil().setHeight(40)),
        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(40)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.all(Radius.circular(ScreenUtil().setSp(25))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(value, style: Theme.of(context).textTheme.body1),
            Icon(Icons.arrow_forward_ios, size: ScreenUtil().setSp(50)),
          ],
        ),
      ),
    );
  }
}
