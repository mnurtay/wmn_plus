import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/registration/index.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({
    Key key,
    GlobalKey<ScaffoldState> scaffoldKey,
    @required RegistrationBloc registrationBloc,
  })  : _registrationBloc = registrationBloc,
        _scaffoldKey = scaffoldKey,
        super(key: key);

  final RegistrationBloc _registrationBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  RegistrationScreenState createState() {
    return RegistrationScreenState(_registrationBloc);
  }
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final RegistrationBloc _registrationBloc;
  RegistrationScreenState(this._registrationBloc);

  void showInSnackBar(String value) {
    widget._scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(value,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(30),
            ))));
  }

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();
  TextEditingController _controllerPasswordVerification =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    this._load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 828, height: 1792, allowFontScaling: true)
          ..init(context);
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        bloc: widget._registrationBloc,
        builder: (
          BuildContext context,
          RegistrationState currentState,
        ) {
          if (currentState is UnRegistrationState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorRegistrationState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ?? 'Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('reload'),
                    onPressed: () => this._load(),
                  ),
                ),
              ],
            ));
          }

          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: headerRegistration(context),
                ),
              ),
              Expanded(
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
                              fontSize: ScreenUtil().setSp(80),
                              fontWeight: FontWeight.w200,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Информации",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(90),
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Выбрать фото профиля",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(40),
                                fontWeight: FontWeight.w300,
                                color: Colors.grey.shade900,
                                letterSpacing: 0.3),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                  height:
                                      ScreenUtil.getInstance().setHeight(310),
                                  width: ScreenUtil.getInstance().setWidth(310),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage("assetName")))),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                        side: BorderSide(color: Colors.grey)),
                                    color: Colors.white,
                                    onPressed: () {
                                      // Navigator.pushNamed(context, "/registration");
                                    },
                                    child: Container(
                                      height: ScreenUtil.getInstance()
                                          .setHeight(50),
                                      width: ScreenUtil.getInstance()
                                          .setWidth(200),
                                      child: Center(
                                        child: Text(
                                          "Убрать фото",
                                          style: TextStyle(
                                              color: Colors.grey.shade900,
                                              fontSize: ScreenUtil().setSp(22)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color: Color(0xFFD748DA))),
                                    color: Color(0xFFD748DA),
                                    onPressed: () {
                                      // Navigator.pushNamed(context, "/registration");
                                    },
                                    child: Container(
                                      height: ScreenUtil.getInstance()
                                          .setHeight(50),
                                      width: ScreenUtil.getInstance()
                                          .setWidth(200),
                                      child: Center(
                                        child: Text(
                                          "Добавить фото",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: ScreenUtil().setSp(22)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                          TextField(
                            keyboardType: TextInputType.text,
                            controller: _controllerName,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _controllerEmail,
                              decoration: InputDecoration(
                                  hintText: "Ваш email?",
                                  hintStyle: TextStyle(
                                      fontSize: ScreenUtil().setSp(40),
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
                                      fontSize: ScreenUtil().setSp(40),
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
                                      fontSize: ScreenUtil().setSp(40),
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
              )),
              InkWell(
                onTap: () {
                  // Navigator.pushNamed(
                  //   context,
                  //   "/registration_mode",
                  // );
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
              )
            ],
          );
        });
  }

  Row headerRegistration(BuildContext context) {
    return Row(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              child: Center(
                  child: Text(
                "1",
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(40)),
              )),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(16.0)),
              height: 60,
              width: 50,
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Expanded(
          child: Container(),
        ),
        Container(
          child: Text("Пропустить"),
        ),
      ],
    );
  }

  void _load([bool isError = false]) {
    widget._registrationBloc.add(UnRegistrationEvent());
    widget._registrationBloc.add(LoadRegistrationEvent(isError));
  }

  void validatePage() {
    if (_controllerName.text.isEmpty) {
      showInSnackBar("Поле имя пусто, заполните пожалуйста");
    } else if (_controllerEmail.text.isEmpty) {
      showInSnackBar("Поле почты пусто, заполните пожалуйста");
    }
    // else if (!_controllerEmail.text.contains(".")) {
    //   showInSnackBar("Формат почты не правильный");
    // }
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
        Navigator.pushNamed(context, "/registration_mode",
            arguments: RegistrationModel(
                name: _controllerName.text.trim(),
                password: _controllerPass.text.trim(),
                email: _controllerEmail.text.trim()));
      }
    }
  }
}
