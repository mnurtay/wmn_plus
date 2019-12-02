import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/registration/registration_mode/index.dart';

class RegistrationModeScreen extends StatefulWidget {
  const RegistrationModeScreen({
    Key key,
    @required RegistrationModeBloc registrationModeBloc,
  })  : _registrationModeBloc = registrationModeBloc,
        super(key: key);

  final RegistrationModeBloc _registrationModeBloc;

  @override
  RegistrationModeScreenState createState() {
    return RegistrationModeScreenState(_registrationModeBloc);
  }
}

class RegistrationModeScreenState extends State<RegistrationModeScreen> {
  final RegistrationModeBloc _registrationModeBloc;
  RegistrationModeScreenState(this._registrationModeBloc);

  Widget buildModeItem(BuildContext context, String mode, String url) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, '/news_detail',
        //     arguments: data.id.toString());
      },
      child: Container(
          margin:
              EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(25)),
          height: ScreenUtil.getInstance().setHeight(400),
          width: MediaQuery.of(context).size.width,
          child: Container(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(ScreenUtil.getInstance().setHeight(50)),
              child: Text(mode,
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(50),
                      color: Colors.white)),
            ),
            decoration: BoxDecoration(
                color: Colors.black38, borderRadius: BorderRadius.circular(10)),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(url)))),
    );
  }

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
    return BlocBuilder<RegistrationModeBloc, RegistrationModeState>(
        bloc: widget._registrationModeBloc,
        builder: (
          BuildContext context,
          RegistrationModeState currentState,
        ) {
          if (currentState is UnRegistrationModeState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorRegistrationModeState) {
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
          return Center(
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildModeItem(context, "Фертилность",
                      "https://ptzgovorit.ru/sites/default/files/styles/700x400/public/original_nodes/182.jpg?itok=Sf08VPjm"),
                  SizedBox(
                    height: 10,
                  ),
                  buildModeItem(context, "Беременность",
                      "https://ptzgovorit.ru/sites/default/files/styles/700x400/public/original_nodes/182.jpg?itok=Sf08VPjm"),
                  SizedBox(
                    height: 10,
                  ),
                  buildModeItem(context, "Климакс",
                      "https://ptzgovorit.ru/sites/default/files/styles/700x400/public/original_nodes/182.jpg?itok=Sf08VPjm"),
                ],
              ),
            ),
          );
        });
  }

  void _load([bool isError = false]) {
    widget._registrationModeBloc.add(UnRegistrationModeEvent());
    widget._registrationModeBloc.add(LoadRegistrationModeEvent(isError));
  }
}
