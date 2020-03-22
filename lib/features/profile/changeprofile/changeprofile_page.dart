import 'package:flutter/material.dart';
import 'package:wmn_plus/features/profile/changeprofile/index.dart';

class ChangeprofilePage extends StatelessWidget {
  static const String routeName = '/changeprofile';

  @override
  Widget build(BuildContext context) {
    var _changeprofileBloc = ChangeprofileBloc();
    return Scaffold(
      appBar: AppBar(
        title: Text("Изменить профиль"),
      ),
      body: ChangeprofileScreen(changeprofileBloc: _changeprofileBloc),
    );
  }
}
