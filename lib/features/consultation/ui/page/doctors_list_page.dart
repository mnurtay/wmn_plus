import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/consultation/ui/widget/doctors_list_data.dart';

class DoctorsListPage extends StatefulWidget {
  final String category;
  DoctorsListPage({@required this.category});
  @override
  _DoctorsListPageState createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
        fontSize: ScreenUtil().setSp(50),
        fontWeight: FontWeight.w200,
        letterSpacing: 0.2);

    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        title: Text(widget.category),
        textTheme: Theme.of(context).textTheme,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(50),
              vertical: ScreenUtil().setHeight(50)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Найди своего', style: textStyle),
              Text(
                'Консультанта',
                style: textStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtil().setSp(75)),
              ),
              SizedBox(height: ScreenUtil().setHeight(50)),
              DoctorsListData(),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerContent(BuildContext context) {
    TextStyle textStyle = TextStyle(
        fontSize: ScreenUtil().setSp(50),
        fontWeight: FontWeight.w200,
        letterSpacing: 0.2);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(ScreenUtil().setSp(85)),
          bottomRight: Radius.circular(ScreenUtil().setSp(85)),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: ScreenUtil().setHeight(110)),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios, size: ScreenUtil().setSp(60)),
          ),
          SizedBox(height: ScreenUtil().setHeight(20)),
          Text('Найди своего', style: textStyle),
          Text(
            'Консультанта',
            style: textStyle.copyWith(
                fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(75)),
          ),
        ],
      ),
    );
  }
}
