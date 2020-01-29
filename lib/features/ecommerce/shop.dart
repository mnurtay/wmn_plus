import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wmn_plus/features/ecommerce/scoped-models/main.dart';
import 'package:wmn_plus/features/ecommerce/screens/home.dart';

class ShopEcommerce extends StatelessWidget {
  final MainModel _model = MainModel();
  
  @override
  Widget build(BuildContext context) {
    _model.fetchCurrentOrder();
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: {'/home': (context) => HomeScreen()},
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.white,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
