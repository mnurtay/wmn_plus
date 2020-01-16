import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyRegistration extends StatelessWidget {
  const BodyRegistration({
    Key key,
    @required TextEditingController controllerName,
    @required TextEditingController controllerEmail,
    @required TextEditingController controllerPass,
    @required TextEditingController controllerPasswordVerification,
  }) : _controllerName = controllerName, _controllerEmail = controllerEmail, _controllerPass = controllerPass, _controllerPasswordVerification = controllerPasswordVerification, super(key: key);

  final TextEditingController _controllerName;
  final TextEditingController _controllerEmail;
  final TextEditingController _controllerPass;
  final TextEditingController _controllerPasswordVerification;

  @override
  Widget build(BuildContext context) {
    return Expanded(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
                child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Персональные",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(70),
                        fontWeight: FontWeight.w200,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Информации",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(80),
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Конфиденциальность гарантируется *",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(23),
                          fontWeight: FontWeight.w200,
                          color: Colors.grey.shade900,
                          letterSpacing: 0.3),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Как вас зовут?",
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(40),
                          fontWeight: FontWeight.w300,
                          color: Colors.grey.shade900,
                          letterSpacing: 0.3),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                        keyboardType: TextInputType.text,
                        controller: _controllerName,
                        decoration: InputDecoration(
                            hintText: "Ваше имя",
                            hintStyle: TextStyle(
                                fontSize: ScreenUtil().setSp(30),
                                fontWeight: FontWeight.w300,
                                color: Colors.grey.shade700,
                                letterSpacing: 0.3))),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _controllerEmail,
                        decoration: InputDecoration(
                            hintText: "Ваш email?",
                            hintStyle: TextStyle(
                                fontSize: ScreenUtil().setSp(30),
                                fontWeight: FontWeight.w300,
                                color: Colors.grey.shade700,
                                letterSpacing: 0.3))),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                        keyboardType: TextInputType.text,
                        controller: _controllerPass,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Поставьте пароль к вашему профилю",
                            hintStyle: TextStyle(
                                fontSize: ScreenUtil().setSp(30),
                                fontWeight: FontWeight.w300,
                                color: Colors.grey.shade700))),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        keyboardType: TextInputType.text,
                        controller: _controllerPasswordVerification,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Повторите пароль",
                            hintStyle: TextStyle(
                                fontSize: ScreenUtil().setSp(30),
                                fontWeight: FontWeight.w300,
                                color: Colors.grey.shade700))),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              ],
            )),
          ),
        ));
  }
}
