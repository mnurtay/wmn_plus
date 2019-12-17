import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/registration/registration_mode/pregnant_mode/index.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';
import 'package:wmn_plus/util/number_picker.dart';

class PregnantModeScreen extends StatefulWidget {
  PregnantModeScreen({
    Key key,
    @required RegistrationModel registrationModel,
    @required PregnantModeBloc pregnantModeBloc,
  })  : _pregnantModeBloc = pregnantModeBloc,
        _registrationModel = registrationModel,
        super(key: key);

  final PregnantModeBloc _pregnantModeBloc;
  final RegistrationModel _registrationModel;

  @override
  PregnantModeScreenState createState() {
    return PregnantModeScreenState(_pregnantModeBloc);
  }
}

class PregnantModeScreenState extends State<PregnantModeScreen> {
  final PregnantModeBloc _pregnantModeBloc;
  PregnantModeScreenState(this._pregnantModeBloc);
  int _currentValue = 1;
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
    return BlocBuilder<PregnantModeBloc, PregnantModeState>(
        bloc: widget._pregnantModeBloc,
        builder: (
          BuildContext context,
          PregnantModeState currentState,
        ) {
          if (currentState is UnPregnantModeState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorPregnantModeState) {
            return Center(child: Text(currentState.errorMessage ?? 'Error'));
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
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                    child: Column(
                  children: <Widget>[
                    buildHeaderTitle(),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          NumberPicker.integer(
                              initialValue: _currentValue,
                              minValue: 1,
                              maxValue: 42,
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
                                    "недели",
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
              )),
              InkWell(
                onTap: () {
                  var obj = new RegistrationModel(
                      firstname: widget._registrationModel.firstname,
                      surname: "surname",
                      dateOfBirth: 21,
                      pushToken: "00",
                      password: widget._registrationModel.password,
                      phone: widget._registrationModel.phone,
                    pregnancy: Pregnancy(
                      week: _currentValue
                    ));
                      
                  print(obj.toJson().toString());

                  widget._pregnantModeBloc.add(UnPregnantModeEvent());
                  widget._pregnantModeBloc.add(CompleteRegistrationEvent(obj));
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

  void _load([bool isError = false]) {
    widget._pregnantModeBloc.add(UnPregnantModeEvent());
    widget._pregnantModeBloc.add(LoadPregnantModeEvent(isError));
  }

  Column buildHeaderTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Беременность",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(90),
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Text(
            "Выберите неделю беременности",
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
          onTap: (){
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
