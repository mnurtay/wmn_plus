import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmn_plus/features/auth/bloc/bloc.dart';
import 'package:wmn_plus/locale/app_localization.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                _authBloc.add(LoggedOutAuthEvent());
              },
              child: Text('Logout'),
            ),
            RaisedButton(
              onPressed: () {
                _authBloc.add(ChangeAppModeFertilityEvent());
              },
              child: Text('Fertility'),
            ),
            RaisedButton(
              onPressed: () {
                _authBloc.add(ChangeAppModeClimaxEvent());
              },
              child: Text('Climax'),
            ),
            RaisedButton(
              onPressed: () {
                // _authBloc.add(LoggedInAuthEvent());
              },
              child: Text('Pregnant'),
            ),
            Expanded(
              flex: 1,
              child: ListTile(
                leading: RaisedButton(
                  onPressed: () {
                    setState(() {
                      AppLocalization.load(Locale('ru', 'RU'));
                    });
                  },
                  child: Text('RUS'),
                ),
                trailing: RaisedButton(
                  onPressed: () {
                    setState(() {
                      AppLocalization.load(Locale('kz', 'KZ'));
                    });
                  },
                  child: Text('KAZAKH'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                AppLocalization.of(context).heyWorld,
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
