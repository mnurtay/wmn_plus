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
  int week;
  PregnantInstruction instruction;
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
    updateInstruction();
  }

  void updateInstruction() {
    bool check = false;
    setState(() {
      pregnant.instructions.forEach((item) {
        if (selectedDate.compareTo(item.fromDate) >= 0) {
          if (selectedDate.compareTo(item.toDate) <= 0) {
            week = item.week;
            instruction = item;
            check = true;
          }
        }
      });
      if (!check) {
        instruction = null;
      }
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
      child: BlocBuilder(
        bloc: pregnantBloc,
        builder: (context, state) {
          if (state is LoadingPregnantState) {
            return Expanded(
              child: Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (pregnant == null) {
            return Container();
          }
          return buildBody();
        },
      ),
    );
  }

  Widget buildBody() {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(50),
            vertical: ScreenUtil().setHeight(50),
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
                // buildBabyWeekImage(),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(12),
                  ),
                  child: Divider(color: Colors.black.withOpacity(0.2)),
                ),
                buildTasks(),
              ],
            ),
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
            fontSize: ScreenUtil().setSp(45),
            color: Colors.grey,
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(10)),
        buildTaskList(),
      ],
    );
  }

  Widget buildTaskList() {
    if (instruction == null) {
      return Container(
        child: Text('Пусто'),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Text(
        //   "${getInstructionDate(instruction.fromDate)} - ${getInstructionDate(instruction.toDate)}",
        //   style: TextStyle(
        //     fontSize: ScreenUtil().setSp(45),
        //     color: Colors.grey,
        //   ),
        // ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: instruction.messages.map((item) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(item,
                  style: TextStyle(
                      fontFamily: 'HolyFat',
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            );
          }).toList(),
        ),
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
            fontSize: ScreenUtil().setSp(45),
            color: Colors.grey,
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(10)),
        Text(
          'Неделя ${week}',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(50),
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String getInstructionDate(DateTime dateTime) {
    String date = "${dateTime.day} ";
    date += MONTH_NAME[dateTime.month - 1];
    date += ", ${dateTime.year}";
    return date;
  }

  String getDateName() {
    String date = MONTH_NAME[selectedDate.month - 1];
    date += ' ${selectedDate.day}';
    return date;
  }

  buildBabyWeekImage() {
    return pregnant.week == 3
        ? Container(
            color: Colors.lightBlue,
            height: 10,
          )
        : Container(
            color: Colors.lime,
            height: 10,
          );
  }
}
