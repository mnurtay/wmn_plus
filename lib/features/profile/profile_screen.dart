import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wmn_plus/features/auth/bloc/auth_bloc.dart';
import 'package:wmn_plus/features/auth/bloc/auth_event.dart';
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
    _profileBloc.close();
    super.dispose();
  }

  Widget _buildCard({String title, String image, Function navigate}) => Card(
      elevation: 2,
      margin: EdgeInsets.fromLTRB(
        ScreenUtil.getInstance().setSp(20),
        0,
        ScreenUtil.getInstance().setSp(20),
        ScreenUtil.getInstance().setSp(20),
      ),
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.body2,
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

    return BlocBuilder<ProfileBloc, ProfileState>(
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
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil().setHeight(60),
                  ),
                  header(currentState),
                  listSettings(authBloc),
                ],
              ),
            );
          }

          return Center();
        });
  }

  Container listSettings(AuthBloc authBloc) {
    return Container(
      width: ScreenUtil().width,
      margin: EdgeInsets.only(top: ScreenUtil.getInstance().setSp(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
           _buildCard(
              title:
                 "Поменять режим",
              navigate: () {
                Navigator.pushNamed(context, "/settings_language");
              }),
          _buildCard(
              title:
                  AppLocalizations.of(context).tr('settings.language_settings'),
              navigate: () {
                Navigator.pushNamed(context, "/settings_language");
              }),
          _buildCard(
              title:
                  AppLocalizations.of(context).tr('settings.сonnect_with_us'),
              navigate: () => _settingModalBottomSheet(context)),
          _buildCard(
              title: AppLocalizations.of(context).tr('settings.share_app'),
              navigate: () {
                shareApp();
              }),
          _buildCard(
              title: "FAQ",
              navigate: () => Navigator.pushNamed(context, '/faq')),
          _buildCard(
              title: AppLocalizations.of(context).tr('settings.about_us'),
              navigate: () => Navigator.pushNamed(context, '/aboutus')),
          _buildCard(
              title: AppLocalizations.of(context).tr('settings.exit'),
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
      child: Row(
        children: <Widget>[
          // profileAvatar(state),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 4),
                  child: Text(
                    state.hello,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Поменять пароль",
                          style: Theme.of(context).textTheme.body1),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, '/settings_password_change');
                      },
                      child: Icon(
                        Icons.settings,
                        size: ScreenUtil.getInstance().setSp(45),
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                // balanceWidget(state, context),
              ],
            ),
          )
        ],
      ),
    );
  }

  void shareApp() {
    Share.share('Check out our wmnplus@gmail.com');
  }

  void whatsAppOpen() async {
    await FlutterLaunch.launchWathsApp(
        phone: "5534992016545", message: "Hello");
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
                    title: new Text(AppLocalizations.of(context)
                        .tr('settings.share_app_child.write_to_us')),
                    onTap: () {
                      launch("mailto:wmnplus@gmail.com");
                    }),
                new ListTile(
                  leading: new Icon(Icons.send),
                  title: new Text(AppLocalizations.of(context)
                      .tr('settings.share_app_child.write_to_wapp')),
                  onTap: () {
                    whatsAppOpen();
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.call),
                  title: new Text(AppLocalizations.of(context)
                      .tr('settings.share_app_child.call_to_us')),
                  onTap: () {
                    launch("tel:87772221133");
                    // _launchPhone();
                  },
                ),
              ],
            ),
          );
        });
  }
}
