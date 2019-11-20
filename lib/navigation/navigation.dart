import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/auth/bloc/bloc.dart';
import 'package:wmn_plus/features/auth/ui/page/loading_page.dart';
import 'package:wmn_plus/features/auth/ui/page/splash_page.dart';
import 'package:wmn_plus/features/login/ui/doctor/doctor_login.dart';
import 'package:wmn_plus/features/login/ui/page/login_page.dart';
import 'package:wmn_plus/navigation/climax_routes.dart';
import 'package:wmn_plus/navigation/doctor_routes.dart';
import 'package:wmn_plus/navigation/fertility_routes.dart';
import 'package:wmn_plus/navigation/pregnant_routes.dart';
import 'package:wmn_plus/util/config.dart';

ThemeData THEME = ThemeData(
  accentColor: Color(0xffD748DA),
  primaryColor: Color(0xffD748DA),
);

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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthBloc, AuthState>(
          bloc: authBloc,
          builder: (BuildContext context, AuthState state) {
            if (state is UninitializedAuthState) {
              return SplashPage();
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
            if (state is AuthenticatedFertilityModeState) {
              return AuthenticatedFertilityRoutes();
            }
            if (state is AuthenticatedClimaxModeState) {
              return AuthenticatedClimaxRoutes();
            }
          },
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
        '/doctor': (BuildContext context) => DoctorLoginPage()
        // '/signup': (BuildContext context) => SignupPage(),
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
