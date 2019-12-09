import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wmn_plus/features/profile/index.dart';

class ProfilPage extends StatelessWidget {
  static const String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    var _profileBloc = ProfileBloc();
    return Scaffold(
       appBar: AppBar(
          title: Text(AppLocalizations.of(context).tr('profil'), style: Theme.of(context).textTheme.title),
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          ),
      body: ProfileScreen(profileBloc: _profileBloc),
    );
  }
}
