import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/fertility_calendar/calendar/calendar_carousel.dart';
import 'package:wmn_plus/features/fertility_calendar/calendar/classes/event.dart';
import 'package:wmn_plus/features/fertility_calendar/index.dart';
import 'package:wmn_plus/features/fertility_calendar/widget/blue_header.dart';
import 'package:wmn_plus/features/fertility_calendar/widget/fert_header.dart';
import 'package:wmn_plus/features/fertility_calendar/widget/pms_header.dart';
import 'package:wmn_plus/features/fertility_calendar/widget/red_header.dart';

class FertilityCalendarScreen extends StatefulWidget {
  FertilityCalendarScreen({
    Key key,
    @required FertilityCalendarBloc fertilityCalendarBloc,
  })  : _fertilityCalendarBloc = fertilityCalendarBloc,
        super(key: key);

  final FertilityCalendarBloc _fertilityCalendarBloc;
  DateTime _varCurrentTime = DateTime.now();
  DateTime _currentTime = DateTime.now();

  @override
  FertilityCalendarScreenState createState() {
    return FertilityCalendarScreenState(_fertilityCalendarBloc);
  }
}

class FertilityCalendarScreenState extends State<FertilityCalendarScreen> {
  final FertilityCalendarBloc _fertilityCalendarBloc;
  FertilityCalendarScreenState(this._fertilityCalendarBloc);
  List<DateTime> babyDate = [];
  @override
  void initState() {
    super.initState();
    this._load();
  }

  @override
  void dispose() {
    // _fertilityCalendarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 828, height: 1792, allowFontScaling: true)
          ..init(context);
    return BlocBuilder<FertilityCalendarBloc, FertilityCalendarState>(
        bloc: widget._fertilityCalendarBloc,
        builder: (
          BuildContext context,
          FertilityCalendarState currentState,
        ) {
          if (currentState is UnFertilityCalendarState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is InFertilityCalendarState) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  RedHeader(context: context, result: currentState.result),
                  buildDailyCalendar(currentState.result, currentState.language),
                  buildInfoBlock()
                ],
              ),
            );
          }

          if (currentState is InToPmsFertilityCalendarState) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  PMSHeader(context: context, result: currentState.result),
                  buildDailyCalendar(currentState.result, currentState.language),
                  buildInfoBlock()
                ],
              ),
            );
          }
          if (currentState is InToFertFertilityCalendarState) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  FertHeader(context: context, result: currentState.result),
                  buildDailyCalendar(currentState.result, currentState.language),
                  buildInfoBlock()
                ],
              ),
            );
          }
          if (currentState is InBabyFertilityCalendarState) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  BlueHeader(context: context, result: currentState.result),
                  buildDailyCalendar(currentState.result, currentState.language),
                  buildInfoBlock()
                ],
              ),
            );
          }
          if (currentState is ErrorFertilityCalendarState) {
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
        });
  }

  Widget buildDailyCalendar(Result result, String language) {
    return CalendarFertilityCarousel<Event>(
      height: ScreenUtil.getInstance().setHeight(1300),
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => widget._varCurrentTime = date);
      },

      prevMonthDayBorderColor: Colors.black,
      weekendTextStyle: TextStyle(
        color: Colors.black,
      ),
      locale: language,
      thisMonthDayBorderColor: Colors.grey,
      showWeekDays: true,
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
        // print(widget._currentTime.toLocal());
        if (result.babyDays.contains(day)) {
          return Container(
            width: 50,
            height: 50,
            child: Center(
                child: Text(
              day.day.toString(),
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30), color: Colors.white),
            )),
            decoration:
                BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle),
          );
        }

        if (result.redDays.contains(day)) {
          return Container(
            width: 50,
            height: 50,
            child: Center(
                child: Text(
              day.day.toString(),
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30), color: Colors.white),
            )),
            decoration:
                BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          );
        }

        if (result.pMS.contains(day)) {
          return Container(
            width: 50,
            height: 50,
            child: Center(
                child: Text(
              day.day.toString(),
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30), color: Colors.white),
            )),
            decoration:
                BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
          );
        }
      },
      weekdayTextStyle:
          TextStyle(fontSize: ScreenUtil().setSp(30), color: Colors.black),
      weekFormat: false,
      daysHaveCircularBorder: null,
      selectedDateTime: widget._varCurrentTime,

    );
  }

  void _load([bool isError = false]) {
    widget._fertilityCalendarBloc.add(UnFertilityCalendarEvent());
    widget._fertilityCalendarBloc.add(LoadFertilityCalendarEvent(isError));
  }

  buildInfoBlock() {
    return Container();
  }
}



