import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/consultation/model/Doctor.dart';

class DoctorData extends StatefulWidget {
  final Doctor doctor;
  final Function onPressButton;
  DoctorData({@required this.doctor, @required this.onPressButton});
  @override
  _DoctorDataState createState() => _DoctorDataState();
}

class _DoctorDataState extends State<DoctorData> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(50),
          vertical: ScreenUtil().setHeight(50),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: ScreenUtil().setHeight(30)),
            title(context),
            SizedBox(height: ScreenUtil().setHeight(120)),
            body(context),
            SizedBox(height: ScreenUtil().setHeight(50)),
            button(context),
          ],
        ),
      ),
    );
  }

  Widget button(BuildContext context) {
    return Container(
      width: ScreenUtil().width,
      child: RaisedButton(
        onPressed: () => widget.onPressButton(),
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
        color: Color(0xFF7B68EE),
        child: Text('Консультироваться',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: ScreenUtil.getInstance().setSp(50),
                color: Colors.white)),
      ),
    );
  }

  Widget title(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil.getInstance().setSp(300),
            height: ScreenUtil.getInstance().setSp(300),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
              image: DecorationImage(
                image: NetworkImage(widget.doctor.image),
              ),
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(20)),
          Text(
            "${widget.doctor.getFullName}",
            style: Theme.of(context).textTheme.display1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        supportLanguage(context),
        bodyItem(
            context: context,
            title: "Рейтинг",
            leading: Icon(Icons.star, color: Colors.grey),
            value: "4.8"),
        bodyItem(
            context: context,
            title: "Консультировано",
            leading: Icon(Icons.person, color: Colors.grey),
            value: "${widget.doctor.experience}"),
        bodyItem(
            context: context,
            title: "Закончил",
            leading: Icon(Icons.school, color: Colors.grey),
            value: "${widget.doctor.study}"),
        bodyItem(
            context: context,
            title: "Стоимость",
            leading: Icon(Icons.payment, color: Colors.grey),
            value: "${widget.doctor.price} ₸"),
      ],
    );
  }

  Widget bodyItem(
      {@required BuildContext context,
      @required String title,
      @required Widget leading,
      @required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              leading,
              SizedBox(width: ScreenUtil().setWidth(15)),
              Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil.getInstance().setSp(50),
                    color: Color(0xFF1C1C1C),
                  )),
            ],
          ),
          SizedBox(width: ScreenUtil().setWidth(50)),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                value,
                textAlign: TextAlign.right,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil.getInstance().setSp(50),
                  color: Color(0xFF1C1C1C),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget supportLanguage(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Text(
                "Знание языка",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil.getInstance().setSp(50),
                  color: Color(0xFF1C1C1C),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              widget.doctor.kazakhlanguage
                  ? Image.asset(
                      "assets/image/kaz_language.png",
                      width: ScreenUtil().setSp(80),
                      height: ScreenUtil().setHeight(70),
                    )
                  : Container(),
              SizedBox(width: ScreenUtil().setWidth(15)),
              widget.doctor.russianlanguage
                  ? Image.asset(
                      "assets/image/rus_language.png",
                      width: ScreenUtil().setSp(80),
                      height: ScreenUtil().setHeight(70),
                    )
                  : Container(),
              SizedBox(width: ScreenUtil().setWidth(15)),
              widget.doctor.englishlanguage
                  ? Image.asset(
                      "assets/image/en_language.png",
                      width: ScreenUtil().setSp(80),
                      height: ScreenUtil().setHeight(70),
                    )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }
}
