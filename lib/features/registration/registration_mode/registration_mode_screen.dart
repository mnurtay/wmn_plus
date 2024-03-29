import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/registration/registration_mode/index.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';

class RegistrationModeScreen extends StatefulWidget {
  const RegistrationModeScreen({
    Key key,
    @required RegistrationModel registrationModel,
    @required RegistrationModeBloc registrationModeBloc,
  })  : _registrationModeBloc = registrationModeBloc,
        _registrationModel = registrationModel,
        super(key: key);

  final RegistrationModeBloc _registrationModeBloc;
  final RegistrationModel _registrationModel;

  @override
  RegistrationModeScreenState createState() {
    return RegistrationModeScreenState(_registrationModeBloc);
  }
}

class RegistrationModeScreenState extends State<RegistrationModeScreen> {
  final RegistrationModeBloc _registrationModeBloc;
  RegistrationModeScreenState(this._registrationModeBloc);

  Widget buildModeItem(
      BuildContext context, String mode, String url, int version) {
    return InkWell(
      onTap: () {
        if (version == 1)
          Navigator.pushNamed(context, '/registration_mode_fertility',
              arguments: widget._registrationModel);
        else if (version == 2)
          Navigator.pushNamed(context, '/registration_mode_pregnancy',
              arguments: widget._registrationModel);
        else {
          _registrationModeBloc
              .add(CompleteRegistrationModeEvent(widget._registrationModel));
        }
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
              image:
                  DecorationImage(fit: BoxFit.cover, image: AssetImage(url)))),
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
    return Column(
            children: <Widget>[
              Expanded(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      buildHeaderRow(context),
                      SizedBox(
                        height: 20,
                      ),
                      buildMainColumn(context)
                    ],
                  )),
                ),
              )),
            ],
          );
  }

  Column buildMainColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildWelcomeRow(),
        Text(
          "Пожалуйста, выберите свою группу",
          style: TextStyle(
            fontSize: ScreenUtil().setSp(35),
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        buildModeItem(context, "Фертильность", "assets/fert_photo.jpg", 1),
        buildModeItem(context, "Беременность", "assets/preg_photo.jpg", 2),
        buildModeItem(context, "Климакс", "assets/climax_photo.jpg", 3)
      ],
    );
  }

  Widget buildWelcomeRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "Привет",
          style: TextStyle(
            fontSize: ScreenUtil().setSp(80),
            fontWeight: FontWeight.w200,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          widget._registrationModel.firstname,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(90),
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Row buildHeaderRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              child: Center(
                  child: Text(
                "2",
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
            )
          ],
        ),
        Expanded(
          child: Container(),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            child: Text("Назад"),
          ),
        ),
      ],
    );
  }

  void _load([bool isError = false]) {
    widget._registrationModeBloc.add(UnRegistrationModeEvent());
    widget._registrationModeBloc.add(LoadRegistrationModeEvent(isError));
  }
}
