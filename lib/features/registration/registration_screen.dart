import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/registration/index.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({
    Key key,
    @required RegistrationBloc registrationBloc,
  })  : _registrationBloc = registrationBloc,
        super(key: key);

  final RegistrationBloc _registrationBloc;

  @override
  RegistrationScreenState createState() {
    return RegistrationScreenState(_registrationBloc);
  }
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final RegistrationBloc _registrationBloc;
  RegistrationScreenState(this._registrationBloc);

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
          return Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusColor: Colors.red,
                        fillColor: Colors.grey,
                        labelText: "Телефон")),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusColor: Colors.red,
                        fillColor: Colors.grey,
                        labelText: "ФИО")),
                SizedBox(
                  height: 50,
                ),
                TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusColor: Colors.red,
                        fillColor: Colors.grey,
                        labelText: "Пароль")),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusColor: Colors.red,
                        fillColor: Colors.grey,
                        labelText: "Повторите пароль")),
                SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(12.0),
                    ),
                    color: Color(0xffD748DA),
                    onPressed: () {
                      // _onLoginButtonPressed();
                      Navigator.pushNamed(context, "/registration_mode");
                    },
                    child: Container(
                      height: ScreenUtil.getInstance().setHeight(70),
                      margin: EdgeInsets.all(15),
                      child: Center(
                        child: Text(
                          "Продолжить",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _load([bool isError = false]) {
    widget._registrationBloc.add(UnRegistrationEvent());
    widget._registrationBloc.add(LoadRegistrationEvent(isError));
  }
}
