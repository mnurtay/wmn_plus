import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/auth/bloc/bloc.dart';
import 'package:wmn_plus/features/auth/ui/page/loading_page.dart';
import 'package:wmn_plus/features/auth/ui/page/profile_page.dart';
import 'package:wmn_plus/features/auth/ui/page/splash_page.dart';
import 'package:wmn_plus/features/login/ui/page/login_page.dart';
import 'package:wmn_plus/util/config.dart';

ThemeData THEME = ThemeData(
    // textTheme: TextTheme(),
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
              return AuthenticatedApp();
            }
            if (state is UnauthenticatedAuthState) {
              return UnauthenticatedApp();
            }
            if (state is LoadingAuthState) {
              return LoadingPage();
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

/// --- The Authenticated routes ---
class AuthenticatedApp extends StatelessWidget {
  Widget buildRoutes(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: THEME,
      routes: {
        // '/': (BuildContext context) => BottomNavigationController(),
        '/': (BuildContext context) => ProfilePage()
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

// --- Bottom Navigation Controller ---
class BottomNavigationController extends StatefulWidget {
  @override
  _BottomNavigationControllerState createState() =>
      _BottomNavigationControllerState();
}

class _BottomNavigationControllerState
    extends State<BottomNavigationController> {
  int _selectedPage = 0;
  final _pageOptions = [
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
        width: DEVICE_WIDTH, height: DEVICE_HEIGHT, allowFontScaling: true)
      ..init(context);
    return Scaffold(
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        fixedColor: Color(0xFF6078ea),
        items: [
          // Profile Page
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}
