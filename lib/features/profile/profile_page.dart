import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wmn_plus/features/profile/index.dart';

class ProfilPage extends StatelessWidget {
  static const String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    var _profileBloc = ProfileBloc();
    return Scaffold(
      appBar: appBar(context),
      body: ProfileScreen(profileBloc: _profileBloc),
    );
  }

  Widget appBar(BuildContext context) {
    return AppBar(
        title: Text(
          "Профиль",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 4,
        actions: <Widget>[]);
  }
}
