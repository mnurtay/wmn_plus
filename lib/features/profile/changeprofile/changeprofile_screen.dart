import 'package:flare_flutter/flare_actor.dart';
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

  static TextEditingController _controllerName = TextEditingController();
  static TextEditingController _controllerSur = TextEditingController();
  static TextEditingController _controllerEmail = TextEditingController();
  static TextEditingController _controllerPass = TextEditingController();
  static TextEditingController _controllerPasswordVerification =
      TextEditingController();

  String name = "";
  String surname = "";
  String email = "";
  String password = "";

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
    // _changeprofileBloc.close();
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
                    child: Text("Загрузить"),
                    onPressed: () => this._load(),
                  ),
                ),
              ],
            ));
          }
          if (currentState is InChangeprofileState) {
            name = currentState.user.result.firstname;
            surname = currentState.user.result.surname;
            email = currentState.user.result.phone;
            password = currentState.user.result.password;
            // _controllerPasswordVerification.text =
            //     currentState.user.result.password;

            String year = currentState.user.result.dateOfBirth.substring(0, 4);
            String day = currentState.user.result.dateOfBirth.substring(4, 6);
            String month = currentState.user.result.dateOfBirth.substring(6, 8);

            if (currentState.version == 0)
              birthDayDate = "$day.$month.$year";
            else
              birthDayDate = currentState.dateTime;

            birthDayForServer = "$year$day$month";
            print(birthDayForServer);

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
                                    hintText:
                                        currentState.user.result.firstname,
                                    hintStyle: TextStyle(
                                        fontSize: ScreenUtil().setSp(30),
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                        letterSpacing: 0.3))),

                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                                keyboardType: TextInputType.text,
                                controller: _controllerSur,
                                decoration: InputDecoration(
                                    hintText: currentState.user.result.surname,
                                    hintStyle: TextStyle(
                                        fontSize: ScreenUtil().setSp(30),
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                        letterSpacing: 0.3))),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _controllerEmail,
                                decoration: InputDecoration(
                                    hintText: currentState.user.result.phone,
                                    hintStyle: TextStyle(
                                        fontSize: ScreenUtil().setSp(30),
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                        letterSpacing: 0.3))),
                            SizedBox(
                              height: 20,
                            ),
                            // Row(
                            //   children: <Widget>[
                            //     Text("Изменить дату рождения:"),
                            //     SizedBox(width: 5),
                            //     GestureDetector(
                            //         onTap: () {
                            //           String zeroForDay = "0";
                            //           DatePicker.showDatePicker(context,
                            //               showTitleActions: true,
                            //               minTime: DateTime(1920, 3, 5),
                            //               maxTime: DateTime.now(),
                            //               onChanged: (date) {
                            //             print('change $date');
                            //             setState(() {
                            //               birthDayDate =
                            //                   "${date.month}/${date.day}/${date.year}";
                            //               if (date.day < 10) {
                            //                 if (date.month <=
                            //                     DateTime.september)
                            //                   birthDayForServer =
                            //                       "${date.year}0${date.month}0${date.day}";
                            //                 else
                            //                   birthDayForServer =
                            //                       "${date.year}${date.month}0${date.day}";
                            //               } else {
                            //                 if (date.month <=
                            //                     DateTime.september)
                            //                   birthDayForServer =
                            //                       "${date.year}0${date.month}${date.day}";
                            //                 else
                            //                   birthDayForServer =
                            //                       "${date.year}${date.month}${date.day}";
                            //               }
                            //               widget._changeprofileBloc.add(
                            //                   LoadChangeprofileEvent(true,
                            //                       dateTime: birthDayDate));
                            //             });
                            //           }, onConfirm: (date) {
                            //             setState(() {
                            //               birthDayDate =
                            //                   "${date.month}/${date.day}/${date.year}";
                            //               if (date.day < 10) {
                            //                 if (date.month <=
                            //                     DateTime.september) {
                            //                   birthDayDate =
                            //                       "${date.month}/${date.day}/${date.year}";
                            //                   birthDayForServer =
                            //                       "${date.year}0${date.month}0${date.day}";
                            //                 } else {
                            //                   birthDayDate =
                            //                       "${date.month}/${date.day}/${date.year}";
                            //                   birthDayForServer =
                            //                       "${date.year}${date.month}0${date.day}";
                            //                 }
                            //               } else {
                            //                 if (date.month <=
                            //                     DateTime.september) {
                            //                   birthDayDate =
                            //                       "${date.month}/${date.day}/${date.year}";
                            //                   birthDayForServer =
                            //                       "${date.year}0${date.month}${date.day}";
                            //                 } else {
                            //                   birthDayDate =
                            //                       "${date.month}/${date.day}/${date.year}";
                            //                   birthDayForServer =
                            //                       "${date.year}${date.month}${date.day}";
                            //                 }
                            //               }
                            //               widget._changeprofileBloc.add(
                            //                   LoadChangeprofileEvent(true,
                            //                       dateTime: birthDayDate));
                            //             });
                            //           },
                            //               currentTime: DateTime.now(),
                            //               locale: LocaleType.ru);
                            //         },
                            //         child: Container(
                            //           padding: EdgeInsets.all(12),
                            //           color: Theme.of(context).accentColor,
                            //           child: Text(birthDayDate,
                            //               style: TextStyle(
                            //                   fontSize: ScreenUtil().setSp(30),
                            //                   fontWeight: FontWeight.w300,
                            //                   color: Colors.white,
                            //                   letterSpacing: 0.3)),
                            //         )),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            TextField(
                                keyboardType: TextInputType.text,
                                controller: _controllerPass,
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: currentState.user.result.password,
                                    hintStyle: TextStyle(
                                        fontSize: ScreenUtil().setSp(30),
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black))),

                            SizedBox(
                              height: 20,
                            ),
                            RaisedButton(
                                color: Theme.of(context).accentColor,
                                onPressed: _onChangeProfilePressed,
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

          if (currentState is SuccessChangeprofileState) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 200,
                      height: 200,
                      child: FlareActor("assets/check.flr",
                          animation: "Untitled")),
                  Text("Данные успешно изменены",
                      style: TextStyle(fontSize: 20))
                ],
              ),
            );
          }
        });
  }

  initValueToController() {
    if (_controllerName.text.isEmpty) {
      _controllerName.text = name;
    }
    if (_controllerSur.text.isEmpty) {
      _controllerSur.text = surname;
    }
    if (_controllerEmail.text.isEmpty) {
      _controllerEmail.text = email;
    }
    if (_controllerPass.text.isEmpty) {
      _controllerPass.text = password;
    }
  }

  _onChangeProfilePressed() {
    initValueToController();
    Map<String, dynamic> mapBody = new Map();
    mapBody["firstname"] = _controllerName.text.toString();
    mapBody["surname"] = _controllerSur.text.toString();
    mapBody["phone"] = _controllerEmail.text.toString();
    mapBody["password"] = _controllerPass.text.toString();
    mapBody["birthday"] = birthDayForServer.toString();
    widget._changeprofileBloc.add(PostServerChangeprofileEvent(mapBody));
  }

  _load() {
    widget._changeprofileBloc.add(UnChangeprofileEvent());
    widget._changeprofileBloc.add(LoadChangeprofileEvent(true));
  }
}
