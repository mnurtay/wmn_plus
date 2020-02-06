import 'dart:convert';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wmn_plus/features/ecommerce/models/order.dart';
import 'package:wmn_plus/features/ecommerce/scoped-models/main.dart';
import 'package:wmn_plus/features/shop/buy_product/index.dart';

class BuyProductScreen extends StatefulWidget {
  BuyProductScreen({
    Key key,
    @required BuyProductBloc buyProductBloc,
  })  : _buyProductBloc = buyProductBloc,
        super(key: key);
  final BuyProductBloc _buyProductBloc;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  TextEditingController _commentsController = TextEditingController();

  @override
  BuyProductScreenState createState() {
    return BuyProductScreenState(_buyProductBloc);
  }
}

class BuyProductScreenState extends State<BuyProductScreen> {
  final BuyProductBloc _buyProductBloc;
  BuyProductScreenState(this._buyProductBloc);

  int paymentPosition = 0;
  int deliveryPosition = 0;
  String paymentType;
  String deliveryType;

  List<String> _paymentChoose = ['Наличными', 'Kaspi.kz'];
  List<String> _deliveryChoose = ['Самовывоз', 'Доставка'];

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
    return BlocBuilder<BuyProductBloc, BuyProductState>(
        bloc: _buyProductBloc,
        builder: (
          BuildContext context,
          BuyProductState currentState,
        ) {
          if (currentState is UnBuyProductState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorBuyProductState) {
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

          if (currentState is CompleteBuyProductState) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 200,
                      height: 200,
                      child: FlareActor("assets/check.flr",
                          animation: "Untitled")),
                  Text("Заказ успешно выполнено!",
                      style: TextStyle(fontSize: 22))
                ],
              ),
            );
          }
          return Scaffold(
            backgroundColor: Colors.grey.withOpacity(0.2),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "Товары",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: 'HolyFat',
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        itemsList(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildInfoBlock(context),
                  buildPaymentChooser(context),
                  buildDeliveryChooser(context),
                  buildComments(context),
                ],
              ),
            ),
            bottomNavigationBar: _buildBottomNavigationBar(),
          );
        });
  }

  Widget orderList() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return CustomScrollView(
          slivers: <Widget>[
            items(),
          ],
        );
      },
    );
  }

  Widget itemsList() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Container(
        height: 300,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {},
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                  child: Container(
                    height: 80,
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(15),
                                height: 150,
                                width: 100,
                                color: Colors.white,
                                child: FadeInImage(
                                  image: NetworkImage(
                                      model.lineItems[index].image != null
                                          ? model.lineItems[index].image
                                          : ''),
                                  placeholder: AssetImage(
                                      'images/placeholders/no-product-image.png'),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: 10),
                                      width: 150,
                                      child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text:
                                                '${model.lineItems[index].title} ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      model.lineItems[index].price.toString() +
                                          " KZT",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Количество: " +
                                          model.lineItems[index].count
                                              .toString(),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3),
                              Divider()
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                ));
          },
          itemCount: model.lineItems.length,
        ),
      );
    });
  }

  Widget items() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return GestureDetector(
                onTap: () {},
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 1,
                  margin: EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(15),
                                height: 150,
                                width: 100,
                                color: Colors.white,
                                child: FadeInImage(
                                  image: NetworkImage(
                                      model.lineItems[index].image != null
                                          ? model.lineItems[index].image
                                          : ''),
                                  placeholder: AssetImage(
                                      'images/placeholders/no-product-image.png'),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    // Expanded(
                                    // child:
                                    Container(
                                      padding: EdgeInsets.only(top: 10),
                                      width: 150,
                                      child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text:
                                                '${model.lineItems[index].title} ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // TextSpan(
                                          //   text: model
                                          //       .lineItems[index].title
                                          //       ,
                                          //   style: TextStyle(
                                          //       fontSize: 15,
                                          //       fontWeight: FontWeight.w100,
                                          //       color: Colors.black),
                                          // ),
                                        ]),
                                      ),
                                    ),
                                    // ),
                                    // Expanded(
                                    // child:
                                    Container(
                                      padding: EdgeInsets.only(top: 0),
                                      child: IconButton(
                                        iconSize: 24,
                                        color: Colors.grey,
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          model.removeProduct(index + 1);
                                        },
                                      ),
                                    ),
                                    // )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  model.lineItems[index].price.toString() +
                                      " KZT",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                "��оличество",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                              // quantityRow(model, index),
                              SizedBox(height: 3),
                              Divider()
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                ));
          }, childCount: model.lineItems.length),
        );
      },
    );
  }

  Card buildDeliveryChooser(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Доставка",
                    style: TextStyle(
                        fontFamily: 'HolyFat',
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            DropdownButton(
              hint: Text('Выбрать форму доставки'),
              value: deliveryType,
              onChanged: (newValue) {
                setState(() {
                  for (int i = 0; i < _deliveryChoose.length; i++) {
                    if (newValue == _deliveryChoose[i]) {
                      deliveryPosition = i;
                      // _newsBloc.add(LoadNewsEvent(category: i));
                    }
                  }
                  deliveryType = newValue;
                });
              },
              items: _deliveryChoose.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Card buildPaymentChooser(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Оплата",
                    style: TextStyle(
                        fontFamily: 'HolyFat',
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            DropdownButton(
              hint: Text('Выбрать форму оплаты'),
              value: paymentType,
              onChanged: (newValue) {
                setState(() {
                  for (int i = 0; i < _paymentChoose.length; i++) {
                    if (newValue == _paymentChoose[i]) {
                      paymentPosition = i;
                      // _newsBloc.add(LoadNewsEvent(category: i));
                    }
                  }
                  paymentType = newValue;
                });
              },
              items: _paymentChoose.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  _buildBottomNavigationBar() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return BottomAppBar(
          elevation: 4.0,
          child: Container(
              height: 90,
              child: Column(children: [
                Container(height: 1, color: Colors.black.withOpacity(0.3)),
                Container(
                    padding: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Общая сумма заказа: ',
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Text(
                          '${model.order.totalPrice} KZT',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        )
                      ],
                    )),
                paymentButton(context),
              ])));
    });
  }

  Widget paymentButton(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
        width: MediaQuery.of(context).size.width,
        child: model.isLoading
            ? Center(
                child: CircularProgressIndicator(backgroundColor: Colors.green))
            : FlatButton(
                disabledColor: Colors.grey.shade200,
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                color: Colors.deepOrange,
                child: Text(
                  'Заказать',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
                onPressed: () {
                  buyProduct(model.order);
                },
              ),
      );
    });
  }

  void _load([bool isError = false]) {
    widget._buyProductBloc.add(UnBuyProductEvent());
    widget._buyProductBloc.add(LoadBuyProductEvent(isError));
  }

  void buyProduct(Order order) {
    BuyProduct product = BuyProduct(
        privacyPolicy: true,
        phone: widget._phoneController.text.trim().toString(),
        name: widget._nameController.text.trim().toString(),
        email: widget._emailController.text.trim().toString(),
        comments: widget._commentsController.text.trim().toString(),
        payment: paymentType,
        delivery: deliveryType,
        order: order);
    // print(widget._routes);
    widget._buyProductBloc.add(CompleteBuyProductEvent(product));
  }

  buildComments(BuildContext context) {
    return Card(
        elevation: 4.0,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: TextField(
              controller: widget._commentsController,
              decoration: InputDecoration(hintText: "Комментарий к заказу"),
            ),
          ),
        ));
  }

  buildInfoBlock(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Личная информация",
                    style: TextStyle(
                        fontFamily: 'HolyFat',
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            TextField(
              controller: widget._nameController,
              decoration: InputDecoration(hintText: "Имя*"),
            ),
            TextField(
              controller: widget._phoneController,
              decoration: InputDecoration(hintText: "Телефон*"),
            ),
            TextField(
              controller: widget._emailController,
              decoration: InputDecoration(hintText: "Почта*"),
            ),
          ],
        ),
      ),
    );
  }
}
