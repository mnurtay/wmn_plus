import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/profile/change_mode/change_mode_pregnancy/index.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';
import 'package:wmn_plus/util/number_picker.dart';

class ChangeModePregnancyScreen extends StatefulWidget {
  const ChangeModePregnancyScreen({
    Key key,
    @required ChangeModePregnancyBloc changeModePregnancyBloc,
  })  : _changeModePregnancyBloc = changeModePregnancyBloc,
        super(key: key);

  final ChangeModePregnancyBloc _changeModePregnancyBloc;

  @override
  ChangeModePregnancyScreenState createState() {
    return ChangeModePregnancyScreenState();
  }
}

class ChangeModePregnancyScreenState extends State<ChangeModePregnancyScreen> {
  var _currentValue = 1;
  @override
  void initState() {
    super.initState();
    // this._load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                height: 30,
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
                                fontSize: 20,
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
                                fontSize: 20,
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
            var pregnancy = Pregnancy(week: _currentValue);

            widget._changeModePregnancyBloc.add(UnChangeModePregnancyEvent());
            widget._changeModePregnancyBloc
                .add(CompleteChangeModePregnancyEvent(pregnancy));
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
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Text(
            "Выберите неделю беременности",
            style: TextStyle(
              fontSize: 20,
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
    widget._changeModePregnancyBloc.add(UnChangeModePregnancyEvent());
    widget._changeModePregnancyBloc.add(LoadChangeModePregnancyEvent(isError));
  }
}
