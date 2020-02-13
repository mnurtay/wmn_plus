import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/profile/changeprofile/index.dart';

class ChangeprofileScreen extends StatefulWidget {
  const ChangeprofileScreen({
    Key key,
    @required ChangeprofileBloc changeprofileBloc,
  })  : _changeprofileBloc = changeprofileBloc,
        super(key: key);

  final ChangeprofileBloc _changeprofileBloc;

  @override
  ChangeprofileScreenState createState() {
    return ChangeprofileScreenState(_changeprofileBloc);
  }
}

class ChangeprofileScreenState extends State<ChangeprofileScreen> {
  final ChangeprofileBloc _changeprofileBloc;
  ChangeprofileScreenState(this._changeprofileBloc);
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
    _load();
    super.initState();
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

    return BlocBuilder<ChangeprofileBloc, ChangeprofileState>(
        bloc: widget._changeprofileBloc,
        builder: (
          BuildContext context,
          ChangeprofileState currentState,
        ) {
          if (currentState is UnChangeprofileState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorChangeprofileState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ?? 'Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text("reload"),
                    onPressed: () => this._load(),
                  ),
                ),
              ],
            ));
          }
          if (currentState is InChangeprofileState) {
            _controllerName.text = currentState.user.result.firstname;
            _controllerSur.text = currentState.user.result.surname;
            _controllerEmail.text = currentState.user.result.phone;
            _controllerPass.text = currentState.user.result.password;
            _controllerPasswordVerification.text =
                currentState.user.result.password;

            String year = currentState.user.result.dateOfBirth.substring(0, 4);
            String day = currentState.user.result.dateOfBirth.substring(4, 6);
            String month = currentState.user.result.dateOfBirth.substring(6, 8);

            birthDayDate = "$day.$month.$year";

            return Scaffold(
              key: _scaffoldKey,
              body: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
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
                            Row(
                              children: <Widget>[
                                Text("Изменить дату рождения:"),
                                SizedBox(width: 5),
                                GestureDetector(
                                    onTap: () {
                                      String zeroForDay = "0";
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(1920, 3, 5),
                                          maxTime: DateTime.now(),
                                          onChanged: (date) {
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
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                                keyboardType: TextInputType.text,
                                controller: _controllerPass,
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText:
                                        "Поставьте пароль к вашему профилю",
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
                            RaisedButton(
                                color: Theme.of(context).accentColor,
                                onPressed: () {},
                                child: Center(
                                  child: Text("Сохранить",
                                      style: TextStyle(color: Colors.white)),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        });
  }

  _load() {
    widget._changeprofileBloc.add(UnChangeprofileEvent());
    widget._changeprofileBloc.add(LoadChangeprofileEvent(true));
  }
}
