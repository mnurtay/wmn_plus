import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/profile/change_mode/change_mode_fertility/change_mode_fertility_period/index.dart';
import 'package:wmn_plus/features/registration/index.dart';
import 'package:wmn_plus/util/number_picker.dart';

class ChangeModeFertilityPeriodScreen extends StatefulWidget {
  ChangeModeFertilityPeriodScreen(
      {Key key,
      @required ChangeModeFertilityPeriodBloc changeModeFertilityPeriodBloc,
      @required Fertility fertility})
      : _changeModeFertilityPeriodBloc = changeModeFertilityPeriodBloc,
        _fertility = fertility,
        super(key: key);

  final ChangeModeFertilityPeriodBloc _changeModeFertilityPeriodBloc;
  final Fertility _fertility;

  @override
  ChangeModeFertilityPeriodScreenState createState() {
    return ChangeModeFertilityPeriodScreenState(_changeModeFertilityPeriodBloc);
  }
}

class ChangeModeFertilityPeriodScreenState
    extends State<ChangeModeFertilityPeriodScreen> {
  final ChangeModeFertilityPeriodBloc _changeModeFertilityPeriodBloc;
  ChangeModeFertilityPeriodScreenState(this._changeModeFertilityPeriodBloc);
  var _currentValue = 1;
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
    return BlocBuilder<ChangeModeFertilityPeriodBloc,
            ChangeModeFertilityPeriodState>(
        bloc: widget._changeModeFertilityPeriodBloc,
        builder: (
          BuildContext context,
          ChangeModeFertilityPeriodState currentState,
        ) {
          if (currentState is UnChangeModeFertilityPeriodState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorChangeModeFertilityPeriodState) {
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
              SizedBox(
                height: 20,
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
              )),
              InkWell(
                onTap: () {
                  var fert = widget._fertility;
                  fert.period = _currentValue;
                  widget._changeModeFertilityPeriodBloc
                      .add(UnChangeModeFertilityPeriodEvent());
                  widget._changeModeFertilityPeriodBloc
                      .add(CompleteChangeModeFertilityEvent(fert));
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

  void _load([bool isError = false]) {
    widget._changeModeFertilityPeriodBloc
        .add(UnChangeModeFertilityPeriodEvent());
    widget._changeModeFertilityPeriodBloc
        .add(LoadChangeModeFertilityPeriodEvent(isError));
  }
}
