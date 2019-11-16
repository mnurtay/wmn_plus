import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/auth/bloc/bloc.dart';
import 'package:wmn_plus/features/auth/ui/page/loading_page.dart';
import 'package:wmn_plus/features/auth/ui/page/profile_page.dart';
import 'package:wmn_plus/features/auth/ui/page/splash_page.dart';
import 'package:wmn_plus/features/login/ui/doctor/doctor_login.dart';
import 'package:wmn_plus/features/login/ui/page/login_page.dart';
import 'package:wmn_plus/features/news/news_page.dart';
import 'package:wmn_plus/util/config.dart';

ThemeData THEME_MODE_PREGNANCY = ThemeData(
  accentColor: Color(0xffD748DA),
  primaryColor: Color(0xffD748DA),
);

ThemeData THEME_MODE_FERT =
    ThemeData(accentColor: Colors.red, primaryColor: Colors.red);

ThemeData THEME_MODE_CLIMAX =
    ThemeData(accentColor: Colors.brown, primaryColor: Colors.brown);

ThemeData THEME_MODE_DOCTOR = ThemeData(
  accentColor: Color(0xff474DDF),
  primaryColor: Color(0xff474DDF),
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
              return AuthenticatedApp(); // pregnant mode by default
            }
            if (state is AuthenticatedDoctorAuthState) {
              return AuthenticatedDoctorApp();
            }
            if (state is UnauthenticatedAuthState) {
              return UnauthenticatedApp();
            }
            if (state is LoadingAuthState) {
              return LoadingPage();
            }
            if (state is AuthenticatedFertilityModeState) {
              return AuthenticatedFertilityApp();
            }
            if (state is AuthenticatedClimaxModeState) {
              return AuthenticatedClimaxApp();
            }
          },
        ),
      ),
    );
  }
}

/// ---- Doctor routes ---------
class UnAutheticatedDoctorApp extends StatelessWidget {
  Widget buildRoutes(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: THEME_MODE_DOCTOR,
      routes: {
        '/': (BuildContext context) => DoctorLoginPage(),
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

/// --- The Unauthenticated routes ---
class UnauthenticatedApp extends StatelessWidget {
  Widget buildRoutes(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: THEME_MODE_PREGNANCY,
      routes: {
        '/': (BuildContext context) => LoginPage(),
        '/doctor': (BuildContext context) => UnAutheticatedDoctorApp()
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

/// --- The Authenticated for PREGNANT MODE routes ---
class AuthenticatedApp extends StatelessWidget {
  Widget buildRoutes(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: THEME_MODE_PREGNANCY,
      routes: {
        '/': (BuildContext context) => BottomNavigationController(),
        // '/': (BuildContext context) => ProfilePage()
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

/// --- The Authenticated Fertility routes ---
class AuthenticatedFertilityApp extends StatelessWidget {
  Widget buildRoutes(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: THEME_MODE_FERT,
      routes: {
        '/': (BuildContext context) => BottomNavigationFertilityController(),
        // '/': (BuildContext context) => ProfilePage()
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

/// --- The Authenticated Fertility routes ---
class AuthenticatedClimaxApp extends StatelessWidget {
  Widget buildRoutes(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: THEME_MODE_CLIMAX,
      routes: {
        '/': (BuildContext context) => BottomNavigationClimaxController(),
        // '/': (BuildContext context) => ProfilePage()
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

class AuthenticatedDoctorApp extends StatelessWidget {
  Widget buildRoutes(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: THEME_MODE_DOCTOR,
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

// --- Bottom Navigation PREGNANT Controller ---
class BottomNavigationController extends StatefulWidget {
  @override
  _BottomNavigationControllerState createState() =>
      _BottomNavigationControllerState();
}

class _BottomNavigationControllerState
    extends State<BottomNavigationController> {
  int _selectedPage = 0;
  final _pageOptions = [
    NewsPage(),
    ProfilePage(),
    ProfilePage(),
    ProfilePage(),
    ProfilePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
        width: DEVICE_WIDTH, height: DEVICE_HEIGHT, allowFontScaling: true)
      ..init(context);
    return SafeArea(
      child: Scaffold(
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          fixedColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          items: [
            // Profile Page
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Новости'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text('Календарь'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop_two),
              title: Text('Cкидки и Акции'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('Магазин'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('Чат'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Профиль'),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavigationFertilityController extends StatefulWidget {
  @override
  _BottomNavigationFertilityControllerState createState() =>
      _BottomNavigationFertilityControllerState();
}

class _BottomNavigationFertilityControllerState
    extends State<BottomNavigationFertilityController> {
  int _selectedPage = 0;
  final _pageOptions = [
    NewsPage(),
    ProfilePage(),
    ProfilePage(),
    ProfilePage(),
    ProfilePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
        width: DEVICE_WIDTH, height: DEVICE_HEIGHT, allowFontScaling: true)
      ..init(context);
    return SafeArea(
      child: Scaffold(
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          fixedColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          items: [
            // Profile Page
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Новости'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text('Месячные'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop_two),
              title: Text('Cкидки и Акции'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('Магазин'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('Чат'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Профиль'),
            ),
          ],
        ),
      ),
    );
  }
}

/// CLIMAX BOTTOM NAVIGATION
class BottomNavigationClimaxController extends StatefulWidget {
  @override
  _BottomNavigationClimaxControllerState createState() =>
      _BottomNavigationClimaxControllerState();
}

class _BottomNavigationClimaxControllerState
    extends State<BottomNavigationClimaxController> {
  int _selectedPage = 0;
  final _pageOptions = [
    NewsPage(),
    ProfilePage(),
    ProfilePage(),
    ProfilePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
        width: DEVICE_WIDTH, height: DEVICE_HEIGHT, allowFontScaling: true)
      ..init(context);
    return SafeArea(
      child: Scaffold(
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          fixedColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          items: [
            // Profile Page
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Новости'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop_two),
              title: Text('Cкидки и Акции'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('Магазин'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('Чат'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Профиль'),
            ),
          ],
        ),
      ),
    );
  }
}
