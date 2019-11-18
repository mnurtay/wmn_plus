import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/consultation/ui/widget/new_consultation_data.dart';

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
      appBar: PreferredSize(
        preferredSize: Size(null, ScreenUtil().setHeight(300)),
        child: headerContent(context),
      ),
      body: NewConsultationData(),
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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            blurRadius: 15.0,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50)),
      // height: ScreenUtil().setHeight(400),
      // width: ScreenUtil().width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: ScreenUtil().setHeight(100)),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios, size: ScreenUtil().setSp(60)),
          ),
          SizedBox(height: ScreenUtil().setHeight(40)),
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
