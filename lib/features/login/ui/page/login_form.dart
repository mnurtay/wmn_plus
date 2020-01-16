import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/auth/bloc/auth_bloc.dart';
import 'package:wmn_plus/features/login/bloc/bloc.dart';
import 'package:wmn_plus/features/login/bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthBloc authBloc;

  LoginForm({
    Key key,
    @required this.loginBloc,
    @required this.authBloc,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var passwordVisible = true;

  final Color color_1 = Color(0xFFf8A45D);
  final Color color_2 = Color(0xFFF9655B);

  LoginBloc get _loginBloc => widget.loginBloc;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 828, height: 1792, allowFontScaling: true)
          ..init(context);
    return BlocListener(
      bloc: _loginBloc,
      listener: (BuildContext context, LoginState state) {
        if (state is FailureLoginState) showSnackBar(content: state.error);
      },
      child: buildContent(context),
    );
  }

  Widget buildContent(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.body1;
    return BlocBuilder(
      bloc: _loginBloc,
      builder: (
        BuildContext context,
        LoginState state,
      ) {
        return Column(
          children: <Widget>[
            TextField(
                keyboardType: TextInputType.emailAddress,
                controller: loginController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusColor: Colors.red,
                    fillColor: Colors.grey,
                    labelText: "Почта")),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(50),
            ),
            TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: passwordVisible, //This will obscure text dynamically
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                labelText: 'Пароль',
                // Here is key idea
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(70),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Войти",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(45),
                    fontWeight: FontWeight.w400,
                    color: Color(0xffD748DA),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                GestureDetector(
                    onTap: () {
                      _onLoginButtonPressed();
                    },
                    child: ClipOval(
                      child: Container(
                        color: Color(0xffD748DA),
                        height: 70.0, // height of the button
                        width: 70.0, // width of the butto
                        child: Center(
                            child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )),
                      ),
                    )),
              ],
            ),
            SizedBox(height: ScreenUtil.getInstance().setHeight(200)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    _onDoctorButtonPressed();
                  },
                  child: Text(
                    "Я врач",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: ScreenUtil().setSp(40),
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/registration");
                  },
                  child: Text(
                    "Регистрация",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: ScreenUtil().setSp(40),
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildButton(BuildContext context, LoginState state) {
    return GestureDetector(
      onTap: state is! LoadingLoginState ? _onLoginButtonPressed : null,
      child: Container(
        width: ScreenUtil.getInstance().setWidth(800),
        height: ScreenUtil.getInstance().setHeight(90),
        margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil.getInstance().setWidth(25)),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [color_1, color_2]),
            borderRadius: BorderRadius.all(
                Radius.circular(ScreenUtil.getInstance().setSp(50))),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 3.0,
              ),
            ]),
        child: Center(
          child: state is LoadingLoginState
              ? Container(
                  width: ScreenUtil.getInstance().setWidth(60),
                  height: ScreenUtil.getInstance().setHeight(70),
                  child: CircularProgressIndicator(
                      strokeWidth: ScreenUtil.getInstance().setSp(5)),
                )
              : Text('Войти', style: Theme.of(context).textTheme.button),
        ),
      ),
    );
  }

  String deformatUsername() {
    if (_usernameController.text == '') return '';
    String text = '';
    for (int i = 0; i < _usernameController.text.length; i++) {
      if (_usernameController.text[i] != ' ')
        text += _usernameController.text[i];
    }
    String body = text.substring(2);
    int code = int.parse(text.substring(1, 2));
    return (code + 1).toString() + body;
  }

  void showSnackBar({@required String content}) {
    final snackbar = SnackBar(
      content: Text(
        content,
        style: TextStyle(
            fontFamily: 'SFProText',
            fontSize: ScreenUtil.getInstance().setSp(32),
            letterSpacing: 0,
            fontWeight: FontWeight.w600),
      ),
      backgroundColor: Colors.red,
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  bool checkData() {
    if (deformatUsername().length != 11) {
      showSnackBar(content: 'Неверный номер телефона');
      return false;
    } else if (_passwordController.text.length <= 7) {
      showSnackBar(content: 'Пароль должен содержать минимум 8 символов');
      return false;
    }
    return true;
  }

  _onLoginButtonPressed() {
    FocusScope.of(context).requestFocus(new FocusNode());

    _loginBloc.add(LoginUserEvent(
      username: loginController.text.trim(),
      password: passwordController.text.trim(),
    ));
  }

  void _onDoctorButtonPressed() {
    Navigator.pushNamed(context, '/doctor');
  }
}
