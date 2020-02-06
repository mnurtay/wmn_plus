import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:wmn_plus/features/registration/registration_mode/fertility_mode/fertility_period/index.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';
import 'package:wmn_plus/util/number_picker.dart';

class FertilityPeriodScreen extends StatefulWidget {
  FertilityPeriodScreen({
    Key key,
    @required RegistrationModel registrationModel,
    @required FertilityPeriodBloc fertilityPeriodBloc,
  })  : _fertilityPeriodBloc = fertilityPeriodBloc,
        _registrationModel = registrationModel,
        super(key: key);
  RegistrationModel _registrationModel;
  final FertilityPeriodBloc _fertilityPeriodBloc;

  @override
  FertilityPeriodScreenState createState() {
    return FertilityPeriodScreenState(_fertilityPeriodBloc);
  }
}

class FertilityPeriodScreenState extends State<FertilityPeriodScreen> {
  final FertilityPeriodBloc _fertilityPeriodBloc;
  FertilityPeriodScreenState(this._fertilityPeriodBloc);

  int _currentValue = 1;
  @override
  void initState() {
    super.initState();
    this._load();
  }

  @override
  void dispose() {
    _fertilityPeriodBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 828, height: 1792, allowFontScaling: true)
          ..init(context);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: headerRegistration(context),
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
                child: Column(
              children: <Widget>[
                buildHeaderTitle(),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      NumberPicker.integer(
                          initialValue: _currentValue,
                          minValue: 1,
                          maxValue: 100,
                          onChanged: (newValue) {
                            setState(() => _currentValue = newValue);
                          }),
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                _currentValue.toString(),
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(65),
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "дней",
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(60),
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black,
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
        )),
        InkWell(
          onTap: () {
            var obj = new RegistrationModel(
                firstname: widget._registrationModel.firstname,
                password: widget._registrationModel.password,
                dateOfBirth: widget._registrationModel.dateOfBirth,
                pushToken: "0000000",
                surname: widget._registrationModel.surname,
                phone: widget._registrationModel.phone,
                fertility: Fertility(
                    start: widget._registrationModel.fertility.start,
                    duration: widget._registrationModel.fertility.duration,
                    period: _currentValue));
            print(obj.toJson().toString());

            widget._fertilityPeriodBloc.add(UnFertilityPeriodEvent());
            widget._fertilityPeriodBloc.add(CompleteRegistrationEvent(obj));
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
  }

  void _load([bool isError = false]) {
    widget._fertilityPeriodBloc.add(UnFertilityPeriodEvent());
    widget._fertilityPeriodBloc.add(LoadFertilityPeriodEvent(isError));
  }

  Column buildHeaderTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Цикл",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(90),
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Text(
            "Выберите периодичность месячных",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(35),
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
        ]),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Row headerRegistration(BuildContext context) {
    return Row(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              child: Center(
                  child: Text(
                "3",
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
}
