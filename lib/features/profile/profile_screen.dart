import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wmn_plus/features/auth/bloc/auth_bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_event.dart';
import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/profile/index.dart';
import 'package:wmn_plus/locale/app_localization.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key key,
    @required ProfileBloc profileBloc,
  })  : _profileBloc = profileBloc,
        super(key: key);

  final ProfileBloc _profileBloc;

  @override
  ProfileScreenState createState() {
    return ProfileScreenState(_profileBloc);
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  final ProfileBloc _profileBloc;
  ProfileScreenState(this._profileBloc);

  @override
  void initState() {
    super.initState();
    this._load();
  }

  @override
  void dispose() {
    // _profileBloc.close();
    super.dispose();
  }

  Widget _buildCard({String title, String image, Function navigate}) => Card(
      elevation: 2,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontFamily: 'HolyFat',
              fontSize: 15,
              fontWeight: FontWeight.w600),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: ScreenUtil.getInstance().setSp(35),
          color: Colors.black,
        ),
        onTap: navigate,
      ));

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    ScreenUtil.instance =
        ScreenUtil(width: 828, height: 1792, allowFontScaling: true)
          ..init(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topCenter,
              colors: [
            Theme.of(context).accentColor,
            Colors.white,
            Colors.white
          ])),
      child: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: widget._profileBloc,
          builder: (
            BuildContext context,
            ProfileState currentState,
          ) {
            if (currentState is UnProfileState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (currentState is ErrorProfileState) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(currentState.errorMessage ?? 'Error'),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text("reload"),
                      onPressed: () => this._load(),
                    ),
                  ),
                ],
              ));
            }
            if (currentState is InProfileState) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(ScreenUtil.getInstance().setHeight(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // appBar(),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    header(currentState),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),
                    listSettings(authBloc, currentState),
                  ],
                ),
              );
            }

            return Center();
          }),
    );
  }

  Container listSettings(AuthBloc authBloc, InProfileState currentState) {
    return Container(
      width: ScreenUtil().width,
      margin: EdgeInsets.only(top: ScreenUtil.getInstance().setSp(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          changeRegimeWidget(currentState.hello),
          _buildCard(
              title: "Изменить профиль",
              navigate: () => Navigator.pushNamed(context, '/change_profile')),
          // _buildCard(
          //     title:
          //         AppLocalizations.of(context).tr('settings.language_settings'),
          //     navigate: () {
          //       Navigator.pushNamed(context, "/settings_language");
          //     }),
          _buildCard(
              title: "Помощь",
              navigate: () => _settingModalBottomSheet(context)),
          _buildCard(
              title: "Поделиться приложением",
              navigate: () {
                shareApp();
              }),
          // _buildCard(
          //     title: "FAQ",
          //     navigate: () => Navigator.pushNamed(context, '/faq')),
          _buildCard(
              title: "О нас",
              navigate: () => Navigator.pushNamed(context, '/about_us',
                  arguments: "https://www.wmnplus.com")),
          _buildCard(
              title: "Выйти",
              navigate: () {
                authBloc.add(LoggedOutAuthEvent());
              }),
        ],
      ),
    );
  }

  void _load([bool isError = false]) {
    widget._profileBloc.add(UnProfileEvent());
    widget._profileBloc.add(LoadProfileEvent(isError));
  }

  header(InProfileState state) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          (state.hello.regime != "doctor")
              ? Text(
                  state.hello.firstname + " " + state.hello.surname,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontFamily: 'HolyFat',
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                )
              : Container()
          // Row(
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Text(
          //           "Поменять пароль",
          //           style: Theme.of(context).textTheme.body1),
          //     ),
          //     InkWell(
          //       onTap: () {
          //         Navigator.pushNamed(
          //             context, '/settings_password_change');
          //       },
          //       child: Icon(
          //         Icons.settings,
          //         size: ScreenUtil.getInstance().setSp(45),
          //         color: Colors.grey,
          //       ),
          //     ),
          //   ],
          // ),

          // balanceWidget(state, context),
        ],
      ),
    );
  }

  void shareApp() {
    Share.share('wmnpluskz@gmail.com');
  }

  void whatsAppOpen() async {
    await FlutterOpenWhatsapp.sendSingleMessage("+77028928915", "Привет,  ");
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.message),
                    title: new Text("Напишите нам"),
                    onTap: () {
                      launch("mailto:wmnpluskz@gmail.com");
                    }),
                new ListTile(
                  leading: new Icon(Icons.send),
                  title: new Text("Напишите в WhatsApp"),
                  onTap: () {
                    whatsAppOpen();
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.call),
                  title: new Text("Позвонить"),
                  onTap: () {
                    launch("tel:+77028928915");
                    // _launchPhone();
                  },
                ),
              ],
            ),
          );
        });
  }

  appBar() {
    return Text(
      "Профиль",
      style: TextStyle(
        fontSize: ScreenUtil().setSp(65),
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }

  changeRegimeWidget(Result hello) {
    print(hello.regime);
    if (hello.regime == "climax" || hello.regime == "doctor")
      return Container();
    else
      return _buildCard(
          title: "Поменять режим",
          navigate: () {
            Navigator.pushNamed(context, "/settings_change_mode");
          });
  }
}
