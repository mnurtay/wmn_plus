import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wmn_plus/features/auth/resource/auth_repository.dart';
import 'package:wmn_plus/features/pregnant_calendar/bloc/bloc.dart';
import 'package:wmn_plus/util/config.dart';

class PregnantCalendar extends StatefulWidget {
  @override
  _PregnantCalendarState createState() => _PregnantCalendarState();
}

class _PregnantCalendarState extends State<PregnantCalendar> {
  CalendarController controller;
  PregnantBloc pregnantBloc;
  UserRepository userRepository = UserRepository();
  DateTime startDate;

  @override
  void initState() {
    controller = CalendarController();
    pregnantBloc = BlocProvider.of<PregnantBloc>(context);
    getStartTime();
    super.initState();
  }

  Future<void> getStartTime() async {
    final user = await userRepository.getCurrentUser();
    setState(() {
      startDate = DateTime.parse(user.result.pregnancy.startSys);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: pregnantBloc,
      listener: (context, state) {
        if (state is TodaysPregnantState) {
          controller.setSelectedDay(DateTime.now());
          pregnantBloc.add(InitialPregnantEvent());
        }
      },
      child: buildCalendar(context),
    );
  }

  Widget buildCalendar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setSp(20),
      ),
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(30),
      ),
      child: TableCalendar(
        calendarController: controller,
        startDay: startDate,
        headerVisible: false,
        calendarStyle: CalendarStyle(
          todayColor: Color(0xFFa1affc),
          todayStyle: textStyle(Colors.white, 45),
          selectedStyle: textStyle(Colors.white, 45),
          weekdayStyle: textStyle(Colors.black, 45),
          weekendStyle: textStyle(Colors.black, 45),
          outsideStyle: textStyle(Colors.black.withOpacity(0.3), 45),
          outsideWeekendStyle: textStyle(Colors.black.withOpacity(0.3), 45),
          contentPadding: EdgeInsets.all(0),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          dowTextBuilder: weekDays,
          weekdayStyle: textStyle(Colors.black, 35),
          weekendStyle: textStyle(Colors.red, 35),
        ),
        startingDayOfWeek: StartingDayOfWeek.monday,
        initialCalendarFormat: CalendarFormat.week,
        onDaySelected: (date, list) {
          pregnantBloc.add(SelectDatePregnantEvent(date));
        },
      ),
    );
  }

  TextStyle textStyle(Color color, int size) {
    return TextStyle(
      color: color,
      fontSize: ScreenUtil().setSp(size),
      fontWeight: FontWeight.w400,
    );
  }

  String weekDays(DateTime date, dynamic data) {
    return DAYS_NAME[date.weekday - 1];
  }
}
