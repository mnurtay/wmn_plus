import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/pregnant_calendar/bloc/bloc.dart';
import 'package:wmn_plus/features/pregnant_calendar/model/Pregnant.dart';
import 'package:wmn_plus/util/config.dart';

class PregnantData extends StatefulWidget {
  @override
  _PregnantDataState createState() => _PregnantDataState();
}

class _PregnantDataState extends State<PregnantData> {
  PregnantBloc pregnantBloc;
  Pregnant pregnant;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    pregnantBloc = BlocProvider.of<PregnantBloc>(context);
    super.initState();
  }

  void updatePregnant(Pregnant instance, DateTime date) {
    setState(() {
      pregnant = instance;
      selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: pregnantBloc,
      listener: (context, state) {
        if (state is SelectedDatePregnantState) {
          updatePregnant(state.pregnant, state.dateTime);
        }
        if (state is TodaysPregnantState) {
          updatePregnant(state.pregnant, DateTime.now());
        }
      },
      child: buildBody(),
    );
  }

  Widget buildBody() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(200),
          top: ScreenUtil().setHeight(100),
          left: ScreenUtil().setWidth(100),
          right: ScreenUtil().setWidth(100),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 2),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(ScreenUtil().setSp(60)),
          ),
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(50),
            vertical: ScreenUtil().setHeight(40),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildTitle(),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(20),
                ),
                child: Divider(),
              ),
              buildTasks(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTasks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Задачи:',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(50),
            color: Colors.grey,
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(10)),
      ],
    );
  }

  Widget buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Беременность:',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(50),
            color: Colors.grey,
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(10)),
        // Text(
        //   'Неделя ${pregnant.week}, День ${pregnant.day}',
        //   style: TextStyle(
        //     fontSize: ScreenUtil().setSp(50),
        //     color: Colors.black,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),
      ],
    );
  }

  String getDateName() {
    String date = MONTH_NAME[selectedDate.month - 1];
    date += ' ${selectedDate.day}';
    return date;
  }
}
