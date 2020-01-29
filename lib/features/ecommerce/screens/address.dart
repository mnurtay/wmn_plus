import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wmn_plus/features/ecommerce/models/line_item.dart';
import 'package:wmn_plus/features/ecommerce/scoped-models/main.dart';
import 'package:wmn_plus/features/ecommerce/screens/payment.dart';
import 'package:wmn_plus/features/ecommerce/screens/update_address.dart';
import 'package:wmn_plus/features/ecommerce/utils/connectivity_state.dart';
import 'package:wmn_plus/features/ecommerce/utils/locator.dart';
import 'package:wmn_plus/features/ecommerce/widgets/order_details_card.dart';
import 'package:wmn_plus/features/ecommerce/widgets/snackbar.dart';
import 'package:wmn_plus/features/ecommerce/utils/constants.dart';

import 'package:scoped_model/scoped_model.dart';

class AddressPage extends StatefulWidget {
  AddressPage();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddressPageState();
  }
  // @override
  // State<StatefulWidget> createState() {
  //   return _AddressPageState()
  //   // return _AddressPageState();
  // }
}

class _AddressPageState extends State<AddressPage> {
  bool stateChanged = true;
  String promocode;
  Size _deviceSize;
  String promoCodeResponseMsg = '';
  bool promoChecked = false;
  bool isPromoDiscount = false;
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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

  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              centerTitle: false,
              title: Text('Review Order'),
              bottom: model.isLoading
                  ? PreferredSize(
                      child: LinearProgressIndicator(),
                      preferredSize: Size.fromHeight(10),
                    )
                  : PreferredSize(
                      child: Container(),
                      preferredSize: Size.fromHeight(10),
                    )),
          body: Stack(children: [
            CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 35.0),
                      child: Text(
                        'Shipping Address',
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w200,
                            fontSize: 16.0),
                      ),
                    ),
                    
                    SizedBox(
                      height: 35,
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 0.0),
                      child: Text(
                        'Promotion',
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w200,
                            fontSize: 16.0),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, top: 15.0, bottom: 10.0),
                      child: Text(
                        'Order Summary',
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                    items(model.lineItems),
                    orderDetailCard(),
                    Divider(
                      indent: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        privacyPolicy,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                    Container(
                      height: 150,
                    )
                  ]),
                ),
              ],
            ),
            Positioned(bottom: 0, child: bottomContainer(model))
          ]));
    });
  }

  // Widget paymentButton(BuildContext context) {
  //   return ScopedModelDescendant<MainModel>(
  //       builder: (BuildContext context, Widget child, MainModel model) {
  //     return Container(
  //       padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
  //       width: MediaQuery.of(context).size.width,
  //       child: model.isLoading
  //           ? Center(
  //               child: CircularProgressIndicator(backgroundColor: Colors.green))
  //           : FlatButton(
  //               disabledColor: Colors.grey.shade200,
  //               // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  //               color: Colors.deepOrange,
  //               child: Text(
  //                 'PLACE ORDER',
  //                 style: TextStyle(
  //                     fontSize: 15,
  //                     color: Colors.white,
  //                     fontWeight: FontWeight.w300),
  //               ),
  //               onPressed: model.order.shipAddress != null
  //                   ? () {
  //                       MaterialPageRoute address = MaterialPageRoute(
  //                           builder: (context) =>
  //                               UpdateAddress(model.order.shipAddress, true));

  //                       model.order.shipAddress != null
  //                           ? pushPaymentScreen(model)
  //                           : Navigator.push(context, address);
  //                     }
  //                   : null,
  //             ),
  //     );
  //   });
  // }

  Widget textFieldContainer(String text) {
    return Container(
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
      ),
    );
  }

  // pushPaymentScreen(MainModel model) async {
  //   if (model.order.state == 'delivery' || model.order.state == 'address') {
  //     // print('STATE IS DELIVERY/ADDRESS, CHANGE STATE');
  //     bool _stateischanged = await model.changeState();
  //     if (_stateischanged) {
  //       if (model.order.state == 'delivery') {
  //         _stateischanged = await model.changeState();
  //       }
  //     }
  //     setState(() {
  //       stateChanged = _stateischanged;
  //     });
  //   }
  //   if (stateChanged) {
  //     print('STATE IS CHANGED, FETCH CURRENT ORDER');
  //     bool fetched = await model.fetchCurrentOrder();
  //     bool paymentFetched = await model.getPaymentMethods();
  //     MaterialPageRoute payment =
  //         MaterialPageRoute(builder: (context) => PaymentScreen());
  //     Navigator.push(context, payment);
  //   }
  // }

  
  
  Widget bottomContainer(MainModel model) {
    return BottomAppBar(
        child: Container(
            height: 90,
            child: Column(children: [
              Container(
                  padding: EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Order Total: ',
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        '${model.order.totalQuantity}',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      )
                    ],
                  )),
              // paymentButton(context),
            ])));
  }

  Widget items(List<LineItem> lineItems) {
    return ListView.builder(
      itemCount: lineItems.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              margin: EdgeInsets.all(4.0),
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
                              margin: EdgeInsets.all(14),
                              padding: EdgeInsets.all(10),
                              height: 80,
                              width: 80,
                              color: Colors.white,
                              child: FadeInImage(
                                image: NetworkImage(
                                    lineItems[index].variant.image != null
                                        ? lineItems[index].variant.image
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, top: 10.0),
                                        child: RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text:
                                                  '${lineItems[index].variant.name.split(' ')[0]} ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: lineItems[index]
                                                  .variant
                                                  .name
                                                  .substring(
                                                      lineItems[index]
                                                              .variant
                                                              .name
                                                              .split(' ')[0]
                                                              .length +
                                                          1,
                                                      lineItems[index]
                                                          .variant
                                                          .name
                                                          .length),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Qty: ${lineItems[index].quantity.toString()}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w200,
                                            fontSize: 14),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right: 24.0),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          lineItems[index].variant.displayPrice,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey.shade700,
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        )
                      ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
