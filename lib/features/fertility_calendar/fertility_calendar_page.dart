import 'package:flutter/material.dart';
import 'package:wmn_plus/features/fertility_calendar/index.dart';

class FertilityCalendarPage extends StatelessWidget {
  static const String routeName = '/fertilityCalendar';

  @override
  Widget build(BuildContext context) {
    var _fertilityCalendarBloc = FertilityCalendarBloc();
    return Scaffold(
      body: FertilityCalendarScreen(fertilityCalendarBloc: _fertilityCalendarBloc),
    );
  }
}
