import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wmn_plus/features/ecommerce/scoped-models/main.dart';
import 'package:wmn_plus/features/ecommerce/screens/account.dart';
import 'package:wmn_plus/features/ecommerce/screens/auth.dart';
import 'package:wmn_plus/features/ecommerce/screens/order_history.dart';
import 'package:wmn_plus/features/ecommerce/screens/retun_policy.dart';
import 'package:wmn_plus/features/ecommerce/utils/constants.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'headers.dart';

class HomeDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeDrawer();
  }
}

class _HomeDrawer extends State<HomeDrawer> {
  int favCount = 0;
  @override
  void initState() {
    super.initState();
    // getFavoritesCount();
  }

  // getFavoritesCount() async {
  //   favCount = 0;
  //   Map<String, String> headers = await getHeaders();
  //   Map<String, dynamic> responseBody = Map();
  //   http
  //       .get(
  //           Settings.SERVER_URL +
  //               'spree/user_favorite_products.json?&data_set=small',
  //           headers: headers)
  //       .then((response) {
  //     responseBody = json.decode(response.body);
  //     responseBody['data'].forEach((favoriteObj) {
  //       setState(() {
  //         favCount++;
  //       });
  //     });
  //   });
  // }

  String userName = '';
  Widget logOutButton() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (model.isAuthenticated) {
          return ListTile(
            leading: Icon(
              Icons.call_made,
              color: Colors.grey,
            ),
            title: Text(
              'Sign Out',
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              // logoutUser(model);
              _showDialog(context, model);
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget favoritesLineTile() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListTile(
        leading: Icon(
          Icons.favorite,
          color: Colors.green,
        ),
        trailing: Container(
          width: 30.0,
          height: 30.0,
          child: favCount != null && favCount > 0
              ? Stack(
                  children: <Widget>[
                    Icon(Icons.brightness_1, size: 30.0, color: Colors.green),
                    Center(
                      child: Text(
                        '${favCount}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
              : Container(
                  width: 30.0,
                  height: 30.0,
                ),
        ),
        title: Text(
          'Favorites',
          style: TextStyle(color: Colors.green),
        ),
        onTap: () {
          if (model.isAuthenticated) {
          
          } else {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (context) => Authentication(0));

            Navigator.push(context, route);
          }
        },
      );
    });
  }

  Widget accountListTile() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListTile(
        leading: Icon(
          Icons.person,
          color: Colors.green,
        ),
        title: Text(
          'Account',
          style: TextStyle(color: Colors.green),
        ),
        onTap: () {
          if (model.isAuthenticated) {
            MaterialPageRoute account =
                MaterialPageRoute(builder: (context) => Account());
            Navigator.push(context, account);
          } else {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (context) => Authentication(0));

            Navigator.push(context, route);
          }
        },
      );
    });
  }

  Widget orderHistoryLineTile() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListTile(
        leading: Icon(
          Icons.receipt,
          color: Colors.green,
        ),
        title: Text(
          'Order History',
          style: TextStyle(color: Colors.green),
        ),
        onTap: () {
          if (model.isAuthenticated) {
            MaterialPageRoute orderList =
                MaterialPageRoute(builder: (context) => OrderList());
            Navigator.push(context, orderList);
          } else {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (context) => Authentication(0));

            Navigator.push(context, route);
          }
        },
      );
    });
  }

  Widget signInLineTile() {
    getUserName();
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (!model.isAuthenticated) {
          return Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                child: Text(
                  'Sign in',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w300),
                ),
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => Authentication(0));

                  Navigator.push(context, route);
                },
              ),
              Text(' | ',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w300)),
              GestureDetector(
                child: Text('Create Account',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300)),
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => Authentication(1));

                  Navigator.push(context, route);
                },
              )
            ],
          ));
        } else {
          return Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('Hi, ${formatName()}!',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500))
              ],
            ),
          );
        }
      },
    );
  }

  formatName() {
    if (userName != null) {
      return userName[0].toUpperCase() + userName.substring(1).split('@')[0];
    }
  }

  getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('email');
    });
  }

    void _showDialog(context, model) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Sign Out"),
            content: new Text("Are you sure you want to sign out?"),
            actions: <Widget>[
              new FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  logoutUser(model);
                },
              )
            ],
          );
        });
  }

  logoutUser(MainModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String user_id = prefs.getInt('id').toString();
    String api_key = prefs.getString('spreeApiKey');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'token-type': 'Bearer',
      'ng-api': 'true',
      'Auth-Token': api_key,
      'uid': user_id
    };
    http
        .get(Settings.SERVER_URL + 'logout.json', headers: headers)
        .then((response) {
      prefs.clear();
      model.clearData();
      model.loggedInUser();
      model.fetchCurrentOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          DrawerHeader(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'WMN Plus',
                style: TextStyle(
                    fontFamily: 'HolyFat', fontSize: 32, color: Colors.white),
              ),
              Text(
                'Интернет - магазин',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
              ),
              // signInLineTile()
            ]),
            decoration: BoxDecoration(color: Colors.purple),
          ),
          ListTile(
            onTap: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
            leading: Icon(
              Icons.home,
              color: Colors.purple,
            ),
            title: Text(
              'Главная страница магазина',
              style: TextStyle(color: Colors.purple),
            ),
          ),
          // favoritesLineTile(),
          // accountListTile(),
          Divider(color: Colors.grey,),
          
          InkWell(
            onTap: () {
              _callMe('+77028928915');
            },
            child: ListTile(
              leading: Icon(
                Icons.call,
              ),
              title: Text(
                'Позвонить: +77028928915',
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _sendMail('wmnpluskz@gmail.com');
            },
            child: ListTile(
              leading: Icon(
                Icons.mail,
              ),
              title: Text(
                'Email: wmnpluskz@gmail.com',
              ),
            ),
          ),
          
          Divider(color: Colors.grey,),
          // logOutButton()
        ],
      ),
    );
  }
}

_sendMail(String email) async {
  // Android and iOS
  final uri = 'mailto:$email?subject=&body=';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}

_callMe(String phone) async {
  final uri = 'tel:$phone';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}
