import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/registration/registration_mode/fertility_mode/index.dart';
import 'package:wmn_plus/features/registration/registration_model.dart';
import 'package:wmn_plus/util/calendar/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:wmn_plus/util/calendar/classes/event.dart';

class FertilityModeScreen extends StatefulWidget {
  FertilityModeScreen({
    Key key,
    @required RegistrationModel registrationModel,
    @required FertilityModeBloc fertilityModeBloc,
  })  : _fertilityModeBloc = fertilityModeBloc,
        _registrationModel = registrationModel,
        super(key: key);
  RegistrationModel _registrationModel;
  final FertilityModeBloc _fertilityModeBloc;
  DateTime _varCurrentTime = DateTime.now();
  DateTime _currentTime = DateTime.now();

  @override
  FertilityModeScreenState createState() {
    return FertilityModeScreenState(_fertilityModeBloc);
  }
}

class FertilityModeScreenState extends State<FertilityModeScreen> {
  final FertilityModeBloc _fertilityModeBloc;
  FertilityModeScreenState(this._fertilityModeBloc);
  PageController controller = PageController();
  var currentPageValue = 0.0;

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

    return BlocBuilder<FertilityModeBloc, FertilityModeState>(
        bloc: widget._fertilityModeBloc,
        builder: (
          BuildContext context,
          FertilityModeState currentState,
        ) {
          if (currentState is UnFertilityModeState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorFertilityModeState) {
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
        });
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

  void _load([bool isError = false]) {
    widget._fertilityModeBloc.add(UnFertilityModeEvent());
    widget._fertilityModeBloc.add(LoadFertilityModeEvent(isError));
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
        //      weekDays: null, /// for pass null when you do not want to render weekDays
        //      headerText: Container( /// Example for rendering custom header
        //        child: Text('Custom Header'),
        //      ),
        customDayBuilder: (
          /// you can provide your own build function to make custom day containers
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
                width: 50,
                height: 50,
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
      return "Августа";
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

  void nextPageTap() {
    RegistrationModel obj = new RegistrationModel(
      firstname: widget._registrationModel.firstname,
      password: widget._registrationModel.password,
      phone: widget._registrationModel.phone,
      fertility: Fertility(
          start:
              "${widget._varCurrentTime.day}/${widget._varCurrentTime.month}/${widget._varCurrentTime.year}"),
    );
    print(obj.toJson().toString());
    Navigator.pushNamed(context, "/registration_mode_fertility_duration",
        arguments: obj);
  }
}
