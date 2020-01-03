import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/auth/bloc/bloc.dart';
import 'package:wmn_plus/features/auth/ui/page/loading_page.dart';
import 'package:wmn_plus/features/auth/ui/page/splash_page.dart';
import 'package:wmn_plus/features/login/ui/doctor/doctor_login.dart';
import 'package:wmn_plus/features/login/ui/page/login_page.dart';
import 'package:wmn_plus/features/profile/screen/language/language_page.dart';
import 'package:wmn_plus/features/registration/registration_mode/fertility_mode/fertility_duration/fertility_duration_page.dart';
import 'package:wmn_plus/features/registration/registration_mode/fertility_mode/fertility_period/fertility_period_page.dart';
import 'package:wmn_plus/features/registration/registration_mode/fertility_mode/index.dart';
import 'package:wmn_plus/features/registration/registration_mode/pregnant_mode/pregnant_mode_page.dart';
import 'package:wmn_plus/features/registration/registration_mode/registration_mode_page.dart';
import 'package:wmn_plus/features/registration/registration_page.dart';
import 'package:wmn_plus/navigation/climax_routes.dart';
import 'package:wmn_plus/navigation/doctor_routes.dart';
import 'package:wmn_plus/navigation/fertility_routes.dart';
import 'package:wmn_plus/navigation/pregnant_routes.dart';
import 'package:wmn_plus/util/config.dart';

ThemeData THEME = ThemeData(
    accentColor: Color(0xffD748DA),
    primaryColor: Color(0xffD748DA),
    textTheme: TextTheme(
      button: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(50),
          fontWeight: FontWeight.w600),
    ));

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AuthBloc authBloc;

  @override
  void initState() {
    authBloc = AuthBloc();
    authBloc.add(AppStartedAuthEvent());
    super.initState();
  }

  @override
  void dispose() {
    authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          builder: (BuildContext context) => authBloc,
        ),
      ],
      child: EasyLocalizationProvider(
        data: data,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AuthBloc, AuthState>(
            bloc: authBloc,
            builder: (BuildContext context, AuthState state) {
              if (state is UninitializedAuthState) {
                return Splash(data);
              }
              if (state is AuthenticatedAuthState) {
                return AuthenticatedPregnantRoutes(); // pregnant mode by default
              }
              if (state is AuthenticatedDoctorAuthState) {
                return AuthenticatedDoctorRoutes();
              }
              if (state is UnauthenticatedAuthState) {
                return UnauthenticatedApp();
              }
              if (state is LoadingAuthState) {
                return LoadingPage();
              }
              if (state is ChooseLanguageAuthState) {
                return LanguagePage();
              }
              if (state is AuthenticatedFertilityModeState) {
                return AuthenticatedFertilityRoutes();
              }
              if (state is AuthenticatedClimaxModeState) {
                return AuthenticatedClimaxRoutes();
              }
            },
          ),
        ),
      ),
    );
  }
}

/// --- The Unauthenticated routes ---
class UnauthenticatedApp extends StatelessWidget {
  Widget buildRoutes(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: THEME,
      routes: {
        '/': (BuildContext context) => LoginPage(),
        '/doctor': (BuildContext context) => DoctorLoginPage(),
        '/registration': (BuildContext context) => RegistrationPage(),
        // '/signup': (BuildContext context) => SignupPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/registration_mode') {
          return MaterialPageRoute(
              builder: (BuildContext context) =>
                  RegistrationModePage(settings.arguments));
        }
        if (settings.name == '/registration_mode_fertility') {
          return MaterialPageRoute(
              builder: (BuildContext context) =>
                  FertilityModePage(settings.arguments));
        }
        if (settings.name == '/registration_mode_fertility_duration') {
          return MaterialPageRoute(
              builder: (BuildContext context) =>
                  FertilityDurationPage(settings.arguments));
        }
        if (settings.name == '/registration_mode_fertility_period') {
          return MaterialPageRoute(
              builder: (BuildContext context) =>
                  FertilityPeriodPage(settings.arguments));
        }

        if (settings.name == '/registration_mode_pregnancy') {
          return MaterialPageRoute(
              builder: (BuildContext context) =>
                  PregnantModePage(settings.arguments));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
        width: DEVICE_WIDTH, height: DEVICE_HEIGHT, allowFontScaling: true)
      ..init(context);
    return buildRoutes(context);
  }
}
