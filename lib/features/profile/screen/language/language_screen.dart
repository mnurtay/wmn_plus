import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/profile/screen/language/index.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({
    Key key,
    @required LanguageBloc languageBloc,
    data,
  })  : _languageBloc = languageBloc,
        _data = data,
        super(key: key);
  final dynamic _data;
  final LanguageBloc _languageBloc;
  @override
  LanguageScreenState createState() {
    return LanguageScreenState(_languageBloc);
  }
}

class LanguageScreenState extends State<LanguageScreen> {
  final LanguageBloc _languageBloc;
  LanguageScreenState(this._languageBloc);
  static Widget _buildCard({String title, String image, Function change}) =>
      Card(
        margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setSp(30)),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(40)),
          ),
          leading:
              Image.asset(image, width: ScreenUtil.getInstance().setSp(90)),
          onTap: change,
        ),
      );

  @override
  void initState() {
    super.initState();
    this._load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
        bloc: widget._languageBloc,
        builder: (
          BuildContext context,
          LanguageState currentState,
        ) {
          if (currentState is UnLanguageState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorLanguageState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ?? 'Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('reload'),
                    onPressed: () => this._load(),
                  ),
                ),
              ],
            ));
          }
          return Container(
              margin: EdgeInsets.only(top: ScreenUtil.getInstance().setSp(20)),
              child: ListView(
                children: <Widget>[
                  _buildCard(
                    title: 'Қазақша',
                    image: 'assets/kazakhstan.png',
                    change: () {
                      _changeLanguage(LanguageType.Kazakh);
                      setState(() {
                        widget._data.changeLocale(Locale("kk", "KZ"));
                      });
                      Navigator.pop(context);
                    },
                  ),
                  _buildCard(
                    title: 'Русский',
                    image: 'assets/russia.png',
                    change: () {
                      _changeLanguage(LanguageType.Russian);
                      setState(() {
                        widget._data.changeLocale(Locale("ru", "RU"));
                      });
                      Navigator.pop(context);
                    },
                  ),
                  _buildCard(
                    title: 'English',
                    image: 'assets/united-kingdom.png',
                    change: () {
                      _changeLanguage(LanguageType.English);
                      setState(() {
                        widget._data.changeLocale(Locale("en", "US"));
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ));
        });
  }

  void _load([bool isError = false]) {
    widget._languageBloc.add(UnLanguageEvent());
    widget._languageBloc.add(LoadLanguageEvent(isError));
  }

  void _changeLanguage(LanguageType type) {
    widget._languageBloc.add(ChangeLanguageEvent(type));
  }
}
