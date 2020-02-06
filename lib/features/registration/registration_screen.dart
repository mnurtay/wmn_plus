import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/auth/bloc/auth_bloc.dart';
import 'package:wmn_plus/features/registration/index.dart';
import 'package:wmn_plus/features/registration/widgets/body.dart';
import 'package:wmn_plus/features/registration/widgets/header.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  static GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(value,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(30),
            ))));
  }

  var name = "";

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerSur = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();
  TextEditingController _controllerPasswordVerification =
      TextEditingController();

  String birthDayDate = 'Выберите дату рождения';
  String birthDayForServer = "";

  bool policy = false;

  @override
  void initState() {
    super.initState();
    // this._load();
  }

  @override
  void dispose() {
    _controllerSur.dispose();
    _controllerName.dispose();
    _controllerEmail.dispose();
    _controllerPass.dispose();
    _controllerPasswordVerification.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 828, height: 1792, allowFontScaling: true)
          ..init(context);
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: RegistrationHeader(context: context),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
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
                      height: 10,
                    ),
                    TextField(
                        keyboardType: TextInputType.text,
                        controller: _controllerSur,
                        decoration: InputDecoration(
                            hintText: "Ваша фамилия",
                            hintStyle: TextStyle(
                                fontSize: ScreenUtil().setSp(30),
                                fontWeight: FontWeight.w300,
                                color: Colors.grey.shade700,
                                letterSpacing: 0.3))),
                    SizedBox(
                      height: 10,
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
                    GestureDetector(
                        onTap: () {
                          String zeroForDay = "0";
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1920, 3, 5),
                              maxTime: DateTime.now(), onChanged: (date) {
                            print('change $date');
                            setState(() {
                              birthDayDate =
                                  "${date.month}/${date.day}/${date.year}";
                              if (date.day < 10) {
                                if (date.month < 10)
                                  birthDayForServer =
                                      "${date.year}0${date.month}0${date.day}";
                                else
                                  birthDayForServer =
                                      "${date.year}${date.month}0${date.day}";
                              } else {
                                birthDayForServer =
                                    "${date.year}${date.month}${date.day}";
                              }
                            });
                          }, onConfirm: (date) {
                            setState(() {
                              birthDayDate =
                                  "${date.month}/${date.day}/${date.year}";
                              if (date.day < 10) {
                                if (date.month < 10)
                                  birthDayForServer =
                                      "${date.year}0${date.month}0${date.day}";
                                else
                                  birthDayForServer =
                                      "${date.year}${date.month}0${date.day}";
                              } else {
                                birthDayForServer =
                                    "${date.year}${date.month}${date.day}";
                              }
                            });
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.ru);
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          color: Theme.of(context).accentColor,
                          child: Text(birthDayDate,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(30),
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                  letterSpacing: 0.3)),
                        )),
                    SizedBox(
                      height: 10,
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
                      height: 20,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Checkbox(
                    value: policy,
                    onChanged: (val) {
                      setState(() {
                        policy = val;
                      });
                    },
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Я соглашаюсь с "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/about_us",
                                arguments:
                                    "https://wmn-plus.flycricket.io/privacy.html");
                          },
                          child: Text(
                            "Политикой конфиденциальности и Условиями использования",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Checkbox(
                    value: policy,
                    onChanged: (val) {
                      setState(() {
                        policy = val;
                      });
                    },
                  ),
                  Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                              "Я соглашаюсь с с обработкой персональных данных о здоровье для целей функционирования приложения. Узнайте больше в"),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/about_us",
                                  arguments:
                                      "https://wmn-plus.flycricket.io/privacy.html");
                            },
                            child: Text(
                              "Политике конфиденциальности",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).accentColor),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ],
          ),
          buildBottomButton()
        ],
      ),
    );
  }

  InkWell buildBottomButton() {
    return InkWell(
      onTap: () {
        validatePage();
      },
      child: Container(
        height: 60,
        child: Center(
          child: Icon(
            Icons.arrow_forward,
            size: 35,
          ),
        ),
      ),
    );
  }

  void validatePage() {
    if (_controllerName.text.isEmpty) {
      showInSnackBar("Поле имя пусто, заполните пожалуйста");
    } else if (_controllerEmail.text.isEmpty) {
      showInSnackBar("Поле почты пусто, заполните пожалуйста");
    } else if (!_controllerEmail.text.contains("@")) {
      showInSnackBar("Формат почты не правильный");
    } else if (_controllerPass.text.isEmpty ||
        _controllerPasswordVerification.text.isEmpty) {
      showInSnackBar("Поле пароль пусто, заполните пожалуйста");
    } else if (!birthDayDate.contains('/')) {
      showInSnackBar("Выберит�� дату рождения");
    } else if (!policy) {
      showInSnackBar("Соглашения с политикой конфиденциальности");
    } else if (_controllerPass.text.length < 5 &&
        _controllerPasswordVerification.text.length < 5) {
      showInSnackBar("Пароль должен быть больше 4 символов");
    } else if (_controllerPass.text.isNotEmpty &&
        _controllerPasswordVerification.text.isNotEmpty) {
      if (_controllerPass.text.trim() !=
          _controllerPasswordVerification.text.trim())
        showInSnackBar("Пароли не совпадают!");
      else
        Navigator.pushNamed(context, "/registration_mode",
            arguments: RegistrationModel(
                dateOfBirth: birthDayForServer,
                surname: _controllerSur.text.trim(),
                firstname: _controllerName.text.trim(),
                password: _controllerPass.text.trim(),
                phone: _controllerEmail.text.trim()));
    }
  }
}
