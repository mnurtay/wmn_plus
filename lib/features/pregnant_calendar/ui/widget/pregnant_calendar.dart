import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wmn_plus/features/pregnant_calendar/bloc/bloc.dart';

class PregnantCalendar extends StatefulWidget {
  @override
  _PregnantCalendarState createState() => _PregnantCalendarState();
}

class _PregnantCalendarState extends State<PregnantCalendar> {
  CalendarController controller;
  PregnantBloc pregnantBloc;

  @override
  void initState() {
    controller = CalendarController();
    pregnantBloc = BlocProvider.of<PregnantBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtil().setSp(40),
        horizontal: ScreenUtil().setSp(20),
      ),
      child: TableCalendar(
        calendarController: controller,
        headerVisible: false,
        calendarStyle: CalendarStyle(
          todayColor: Theme.of(context).primaryColor.withOpacity(0.6),
          selectedColor: Theme.of(context).primaryColor,
        ),
        startingDayOfWeek: StartingDayOfWeek.monday,
        initialCalendarFormat: CalendarFormat.week,
        onDaySelected: (date, list) {
          pregnantBloc.add(SelectDatePregnantEvent(date));
        },
      ),
    );
  }
}
