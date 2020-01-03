import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/pregnant_calendar/bloc/bloc.dart';
import 'package:wmn_plus/features/pregnant_calendar/ui/widget/pregnant_calendar.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: BlocProvider(
        builder: (context) => pregnantBloc,
        child: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return BlocListener(
      bloc: pregnantBloc,
      listener: (context, state) {
        if (state is SelectedDatePregnantState) {
          setState(() {
            title = calendarHeaderTitle(state.dateTime);
          });
        }
      },
      child: Container(
        child: Column(
          children: <Widget>[
            PregnantCalendar(),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      centerTitle: false,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(60),
        ),
      ),
    );
  }

  String calendarHeaderTitle(DateTime date) {
    String month = MONTH_NAME[date.month - 1];
    return '$month, ${date.year}';
  }
}
