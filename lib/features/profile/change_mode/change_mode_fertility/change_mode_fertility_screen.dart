import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/profile/change_mode/change_mode_fertility/index.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';

class ChangeModeFertilityScreen extends StatefulWidget {
  ChangeModeFertilityScreen({
    Key key,
    @required ChangeModeFertilityBloc changeModeFertilityBloc,
  })  : _changeModeFertilityBloc = changeModeFertilityBloc,
        super(key: key);
  DateTime _varCurrentTime = DateTime.now();
  DateTime _currentTime = DateTime.now();
  final ChangeModeFertilityBloc _changeModeFertilityBloc;

  @override
  ChangeModeFertilityScreenState createState() {
    return ChangeModeFertilityScreenState(_changeModeFertilityBloc);
  }
}

class ChangeModeFertilityScreenState extends State<ChangeModeFertilityScreen> {
  final ChangeModeFertilityBloc _changeModeFertilityBloc;
  ChangeModeFertilityScreenState(this._changeModeFertilityBloc);

  static GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text(value,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(30),
            ))));
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
    ScreenUtil.instance =
        ScreenUtil(width: 828, height: 1792, allowFontScaling: true)
          ..init(context);
    return Scaffold(
      key: _scaffoldKey,
      body: BlocBuilder<ChangeModeFertilityBloc, ChangeModeFertilityState>(
          bloc: widget._changeModeFertilityBloc,
          builder: (
            BuildContext context,
            ChangeModeFertilityState currentState,
          ) {
            if (currentState is UnChangeModeFertilityState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (currentState is ErrorChangeModeFertilityState) {
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
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildHeaderTitle(),
                        buildColumnDynamicDay(),
                        buildDailyCalendar(),
                      ],
                    )),
                  ),
                )),
                buildInkWellNextButton()
              ],
            );
          }),
    );
  }

  Column buildColumnDynamicDay() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Text(
            widget._varCurrentTime.day.toString(),
            style: TextStyle(
              fontSize: ScreenUtil().setSp(60),
              fontWeight: FontWeight.w200,
              color: Colors.black,
            ),
          ),
          Text(
            getMonthText(),
            style: TextStyle(
              fontSize: ScreenUtil().setSp(65),
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ]);
  }

  Column buildHeaderTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Ваш",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(80),
                  fontWeight: FontWeight.w200,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                "Период",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(90),
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Text(
            "Выберите последний день",
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

  Widget buildDailyCalendar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.0),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() => widget._varCurrentTime = date);
        },
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),

        thisMonthDayBorderColor: Colors.grey,
        customDayBuilder: (
          bool isSelectable,
          int index,
          bool isSelectedDay,
          bool isToday,
          bool isPrevMonthDay,
          TextStyle textStyle,
          bool isNextMonthDay,
          bool isThisMonthDay,
          DateTime day,
        ) {
          if (day.difference(widget._currentTime).inMinutes > 0) {
            return AbsorbPointer(
              child: Container(
                width: 55,
                height: 55,
                child: Center(
                    child: Text(
                  day.day.toString(),
                  style: TextStyle(fontSize: ScreenUtil().setSp(30)),
                )),
                decoration:
                    BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
              ),
            );
          }
        },
        weekdayTextStyle: TextStyle(
            fontSize: ScreenUtil().setSp(30), color: Color(0xffD748DA)),
        weekFormat: false,
        // markedDatesMap: _markedDateMap,
        height: 450.0,
        // selectedDateTime: _currentDate,
        daysHaveCircularBorder: null,
        selectedDateTime: widget._varCurrentTime,

        /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
  }

  String getMonthText() {
    if (widget._varCurrentTime.month == 1) {
      return "Января";
    } else if (widget._varCurrentTime.month == 2) {
      return "Февраля";
    } else if (widget._varCurrentTime.month == 3) {
      return "Марта";
    } else if (widget._varCurrentTime.month == 4) {
      return "Апреля";
    } else if (widget._varCurrentTime.month == 5) {
      return "Мая";
    } else if (widget._varCurrentTime.month == 6) {
      return "Июня";
    } else if (widget._varCurrentTime.month == 7) {
      return "Июля";
    } else if (widget._varCurrentTime.month == 8) {
      return "Август������";
    } else if (widget._varCurrentTime.month == 9) {
      return "Сентября";
    } else if (widget._varCurrentTime.month == 10) {
      return "Октября";
    } else if (widget._varCurrentTime.month == 11) {
      return "Ноября";
    } else if (widget._varCurrentTime.month == 12) {
      return "Декабря";
    }
  }

  InkWell buildInkWellNextButton() {
    return InkWell(
      onTap: () {
        nextPageTap();
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
    );
  }

  void nextPageTap() {
    var day = widget._varCurrentTime.day.toString();
    var month = widget._varCurrentTime.month.toString();
    if (widget._varCurrentTime.day < 10) {
      day = "0${widget._varCurrentTime.day}";
    }
    if (widget._varCurrentTime.month < 10) {
      month = "0${widget._varCurrentTime.month}";
    }

    if (checkToValidDay()) {
      Fertility fert =
          new Fertility(start: "${widget._varCurrentTime.year}$month$day");

      Navigator.pushNamed(context, "/change_mode_fertility_duration",
          arguments: fert);
    } else {
      showInSnackBar("Выберите правильный день!");
    }
  }

  void _load([bool isError = false]) {
    widget._changeModeFertilityBloc.add(UnChangeModeFertilityEvent());
    widget._changeModeFertilityBloc.add(LoadChangeModeFertilityEvent(isError));
  }

  bool checkToValidDay() {
    var day = widget._varCurrentTime.day;
    if (day > widget._currentTime.day) {
      return false;
    }
    return true;
  }
}
