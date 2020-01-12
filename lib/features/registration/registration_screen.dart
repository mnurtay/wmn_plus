import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();
  TextEditingController _controllerPasswordVerification =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    // this._load();
  }

  @override
  void dispose() {
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
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: RegistrationHeader(context: context),
            ),
          ),
          BodyRegistration(
              controllerName: _controllerName,
              controllerEmail: _controllerEmail,
              controllerPass: _controllerPass,
              controllerPasswordVerification: _controllerPasswordVerification),
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
    }
    else if (!_controllerEmail.text.contains("@")) {
      showInSnackBar("Формат почты не правильный");
    }
    else if (_controllerPass.text.isEmpty ||
        _controllerPasswordVerification.text.isEmpty) {
      showInSnackBar("Поле пароль пусто, заполните пожалуйста");
    } else if (_controllerPass.text.length > 5 &&
        _controllerPasswordVerification.text.length > 5) {
      showInSnackBar("Пароль должен быть больше 5 символов");
    } else if (_controllerPass.text.isNotEmpty &&
        _controllerPasswordVerification.text.isNotEmpty) {
      if (_controllerPass.text.trim() !=
          _controllerPasswordVerification.text.trim())
        showInSnackBar("Пароли не совпадают!");
      else {
        // widget._registrationBloc.add(CompleteRegistrationEvent());
        Navigator.pushNamed(context, "/registration_mode",
            arguments: RegistrationModel(
                firstname: _controllerName.text.trim(),
                password: _controllerPass.text.trim(),
                phone: _controllerEmail.text.trim()));
      }
    }
  }
}
