import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmn_plus/features/shop/buy_product/index.dart';

class BuyProductScreen extends StatefulWidget {
  BuyProductScreen({
    Key key,
    @required Map<String, int> routes,
    @required BuyProductBloc buyProductBloc,
  })  : _routes = routes,
        _buyProductBloc = buyProductBloc,
        super(key: key);
  final Map<String, int> _routes;
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

  List<String> _paymentChoose = ['Cash', 'Kaspi.kz'];
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
        bloc: widget._buyProductBloc,
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
                  Text("Заказ успешно выполнено!", style: TextStyle(fontSize: 22))
                ],
              ),
            );
          }
          return Scaffold(
            backgroundColor: Colors.grey.withOpacity(0.3),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  buildInfoBlock(context),
                  buildPaymentChooser(context),
                  buildDeliveryChooser(context),
                  buildComments(context)
                ],
              ),
            ),
            bottomNavigationBar: _buildBottomNavigationBar(),
          );
        });
  }

  Card buildDeliveryChooser(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Доставка"),
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
        height: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Оплата"),
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
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(4.0),
      width: MediaQuery.of(context).size.width,
      height: 60.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
              flex: 2,
              child: Container(
                  color: Colors.white, child: Text("Сумма: 25000 KZT"))),
          Expanded(
            child: Container(),
          ),
          Flexible(
            flex: 1,
            child: RaisedButton(
              onPressed: () {
                buyProduct();
              },
              color: Color(0xff0CB19A4),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Заказать",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _load([bool isError = false]) {
    widget._buyProductBloc.add(UnBuyProductEvent());
    widget._buyProductBloc.add(LoadBuyProductEvent(isError));
  }

  void buyProduct() {
    BuyProduct product = BuyProduct(
      categoryId: widget._routes["cat"],
      subcategoryId: widget._routes["sub"],
      productId: widget._routes["id"],
      privacyPolicy: true,
      phone: widget._phoneController.text.trim().toString(),
      name: widget._nameController.text.trim().toString(),
      email: widget._emailController.text.trim().toString(),
      comments: widget._commentsController.text.trim().toString(),
      count: 1,
      payment: paymentType,
      delivery: deliveryType,
    );
    widget._buyProductBloc.add(CompleteBuyProductEvent(product));
  }

  buildComments(BuildContext context) {
    return Card(
        elevation: 4.0,
        child: Container(
          height: 100,
          color: Colors.white,
          padding: EdgeInsets.all(10.0),
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
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Личная информация"),
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
