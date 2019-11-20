import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/util/config.dart';

class NewConsultationPage extends StatefulWidget {
  @override
  _NewConsultationPageState createState() => _NewConsultationPageState();
}

class _NewConsultationPageState extends State<NewConsultationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        title: Text('Новая консультация'),
        backgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: ScreenUtil().setHeight(20)),
            categoriesContent(context),
            SizedBox(height: ScreenUtil().setHeight(40)),
          ],
        ),
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
      onTap: () =>
          Navigator.pushNamed(context, '/doctors_list', arguments: value),
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
