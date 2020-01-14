import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/pregnant_calendar/bloc/bloc.dart';
import 'package:wmn_plus/features/pregnant_calendar/ui/widget/pregnant_calendar.dart';
import 'package:wmn_plus/features/pregnant_calendar/ui/widget/pregnant_data.dart';
import 'package:wmn_plus/util/config.dart';

class PregnantPage extends StatefulWidget {
  @override
  _PregnantPageState createState() => _PregnantPageState();
}

class _PregnantPageState extends State<PregnantPage> {
  PregnantBloc pregnantBloc;
  String title = '';

  @override
  void initState() {
    title = calendarHeaderTitle(DateTime.now());
    pregnantBloc = PregnantBloc();
    pregnantBloc.add(FetchPregnantEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Color(0xFFF5F5F5),
      body: BlocProvider(
        builder: (context) => pregnantBloc,
        child: buildBody(context),
      ),
    );
  }

  void updateTitle(DateTime dateTime) {
    setState(() {
      title = calendarHeaderTitle(dateTime);
    });
  }

  Widget buildBody(BuildContext context) {
    return BlocListener(
      bloc: pregnantBloc,
      listener: (context, state) {
        if (state is SelectedDatePregnantState) {
          updateTitle(state.dateTime);
        }
        if (state is TodaysPregnantState) {
          updateTitle(DateTime.now());
        }
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
              Theme.of(context).accentColor,
              Colors.white,
              Colors.white,
            ])),
        child: Column(
          children: <Widget>[
            PregnantCalendar(),
            PregnantData(),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: false,
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(60)),
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            pregnantBloc.add(TodaysPregnantEvent());
          },
          child: Container(
            padding: EdgeInsets.only(
              right: ScreenUtil().setWidth(30),
            ),
            child: Icon(
              Icons.today,
              color: Colors.black,
              size: ScreenUtil().setSp(75),
            ),
          ),
        ),
      ],
    );
  }

  String calendarHeaderTitle(DateTime date) {
    String month = MONTH_NAME[date.month - 1];
    return '$month, ${date.year}';
  }
}
