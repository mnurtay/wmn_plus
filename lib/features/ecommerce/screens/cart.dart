import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wmn_plus/features/ecommerce/scoped-models/main.dart';
import 'package:wmn_plus/features/ecommerce/screens/auth.dart';
import 'package:wmn_plus/features/ecommerce/utils/connectivity_state.dart';
import 'package:wmn_plus/features/ecommerce/utils/locator.dart';
import 'package:scoped_model/scoped_model.dart';

class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartState();
  }
}

class _CartState extends State<Cart> {
  List<int> quantities = [];
  bool stateChanged = false;
  static const _ITEM_HEIGHT = 40;
  @override
  void initState() {
    super.initState();
    locator<ConnectivityManager>().initConnectivity(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    locator<ConnectivityManager>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    MainModel().fetchCurrentOrder();
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
              centerTitle: false,
              leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text('Корзина'),
              bottom: model.isLoading
                  ? PreferredSize(
                      child: LinearProgressIndicator(),
                      preferredSize: Size.fromHeight(10),
                    )
                  : PreferredSize(
                      child: Container(),
                      preferredSize: Size.fromHeight(10),
                    )),
          body: !model.isLoading || model.order != null ? body() : Container(),
          bottomNavigationBar: BottomAppBar(
              child: Container(
                  height: 110,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: model.order != null
                          ? itemTotalContainer(model)
                          : Container(),
                    ),
                    proceedToCheckoutButton(),
                    model.order != null ? 
                    Text("Вы переходите, страницу оформление заказа",
                        style: TextStyle(color: Colors.grey, fontSize: 10)) : Container()
                  ]))));
    });
  }

  Widget deleteButton(int index) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Text(model.lineItems[index].count.toString());
    });
  }

  Widget body() {
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

  Widget itemTotalContainer(MainModel model) {
    if (model.order == null) {
      return Container();
    } else {
      var plural = getPluralNumberText(int.parse(model.order.count));
      if (int.parse(model.order.count) == 0) return Text("В корзине пусто");
      return Text("В корзине ${model.order.count} $plural");
    }
    // return Row(
    //   mainAxisSize: MainAxisSize.min,
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: <Widget>[cartData(true), cartData(false)],
    // );
  }

  String getPluralNumberText(int count) {
    if (count >= 1) {
      return "товар";
    } else if (count >= 2 && count <= 4) {
      return "товара";
    } else {
      return "товаров";
    }
  }

  Widget cartData(bool total) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      String getText() {
        return model.order == null
            ? ''
            : model.order.count == '0.0'
                ? ''
                : total
                    ? 'В корзине: '
                    : model.order.count.toString() +
                        " " +
                        getPluralNumberText(int.parse(model.order.count));
      }

      return getText() == null
          ? Text('')
          : Text(
              getText(),
              style: total
                  ? TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold)
                  : TextStyle(
                      fontSize: 16.5,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
            );
    });
  }

  Widget proceedToCheckoutButton() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 58.0,
          padding: EdgeInsets.all(10),
          child: (model.order == null || model.order?.lineItems.length == 0)
              ? FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.grey,
                  child: Text(
                    "Выбрать товары",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                  onPressed: () async {
                    Navigator.popUntil(context,
                        ModalRoute.withName(Navigator.defaultRouteName));
                  })
              : FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.purple,
                  child: Text(
                    "Перейти к покупке",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                  onPressed: () async {
                    Navigator.pushNamed(context, '/buy');
                  }),
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
                                "Количество",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                              quantityRow(model, index),
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

  Widget quantityRow(MainModel model, int lineItemIndex) {
    print(
        "LINE ITEM TOTAL IN HAND, ${model.lineItems[lineItemIndex]} ISBACKORDERABLE ${model.lineItems[lineItemIndex]}");
    return Container(
        height: 60.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Container();
            } else {
              return GestureDetector(
                onTap: () {
                  model.changeProductQuantity(lineItemIndex + 1, index);
                  // model.addProduct(
                  //   product: ,
                  //   quantity: index - model.lineItems[lineItemIndex].quantity,
                  // );
                },
                child: Container(
                    width: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: model.lineItems[lineItemIndex].count == index
                              ? Colors.green
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Text(
                      index.toString(),
                      style: TextStyle(
                          color: model.lineItems[lineItemIndex].count == index
                              ? Colors.green
                              : Colors.grey),
                    )),
              );
            }
          },
        ));
  }
}
