import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wmn_plus/features/ecommerce/models/line_item.dart';
import 'package:wmn_plus/features/ecommerce/models/option_type.dart';
import 'package:wmn_plus/features/ecommerce/models/option_value.dart';
import 'package:wmn_plus/features/ecommerce/models/order.dart';
import 'package:wmn_plus/features/ecommerce/models/payment_methods.dart';
import 'package:wmn_plus/features/ecommerce/models/product.dart';
import 'package:wmn_plus/features/ecommerce/models/variant.dart';
import 'package:wmn_plus/features/ecommerce/models/address.dart';
import 'package:wmn_plus/features/ecommerce/screens/product_detail.dart';
import 'package:wmn_plus/features/ecommerce/utils/constants.dart';
import 'package:wmn_plus/features/ecommerce/utils/headers.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin CartModel on Model {
  bool hi = false;

  List<LineItem> _lineItems = [];
  Order order;
  bool _isLoading = false;
  List<PaymentMethod> _paymentMethods = [];

  Map<dynamic, dynamic> lineItemObject = Map();

  List<LineItem> get lineItems {
    return List.from(_lineItems);
  }

  List _orderList;

  Order get getOrder {
    return order;
  }

  List<PaymentMethod> get paymentMethods {
    return List.from(_paymentMethods);
  }

  bool get isLoading {
    return _isLoading;
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void getProduct(Product product, BuildContext context,
      [bool isSimilarListing = false]) async {
    _isLoading = true;
    notifyListeners();
    // var responseBody;
    http.get(
        Settings.API_URL +
            'productdetail/${product.catId}/${product.subCatId}/${product.id}',
        headers: {"Authorization": "wmn538179 qwerty"}).then((response) {
      var responseBody = json.decode(utf8.decode(response.bodyBytes));
      print(Settings.API_URL +
          'productdetail/${product.catId}/${product.subCatId}/${product.id}');
      print(responseBody.toString());

      Product prod = Product(
        description: responseBody['result']['description'],
        title: responseBody['result']['title'],
        id: responseBody['result']['id'],
        image: "http://194.146.43.98:4000/image?uri=" +
            responseBody['result']['image_urls'][0],
        price: responseBody['result']['price'].toString(),
      );

      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => ProductDetailScreen(prod));
      if (isSimilarListing) Navigator.pop(context);
      Navigator.push(context, route);
      _isLoading = false;
      notifyListeners();
    });
  }

  void addProduct({Product product, int quantity}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("quantity $quantity");

    // _lineItems.clear();
    _isLoading = true;
    final String orderToken = prefs.getString('order');
    print(orderToken);

    if (orderToken != null) {
      createNewLineItem(product, quantity);
    } else {
      createNewOrder(product, quantity);
    }
    notifyListeners();
  }

  void changeProductQuantity(int line, int quantity) async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoading = true;

    List list = jsonDecode(prefs.getString('order'));
    var param = list[line - 1];
    param['quantity'] = quantity;

    list.removeAt(line-1);
    list.insert(line-1, param);

    prefs.setString('order', jsonEncode(list));

    notifyListeners();
    fetchCurrentOrder();
  }

  void removeProduct(int lineItemId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoading = true;

    List list = jsonDecode(prefs.getString('order'));
    list.removeAt(lineItemId-1);
    prefs.setString('order', jsonEncode(list));

    notifyListeners();
    fetchCurrentOrder();
  }

  void createNewOrder(Product product, int quantity) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> lineParam = {
      'product': product.toJson(),
      'quantity': quantity
    };

    List list = [];
    list.add(lineParam);
    print(list);
    prefs.setString('order', jsonEncode(list));
    notifyListeners();

    fetchCurrentOrder();
  }

  void createNewLineItem(Product product, int quantity) async {
    print("CREATING NEW LINEITEM");
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List list = jsonDecode(prefs.getString('order'));

    Map<String, dynamic> lineParam = {
      'product': product.toJson(),
      'quantity': quantity
    };

    list.add(lineParam);

    print(list);
    prefs.setString('order', jsonEncode(list));
    notifyListeners();
    fetchCurrentOrder();
  }

  Future<void> fetchCurrentOrder() async {
    print("FETCH CURRENT ORDER");
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _isLoading = true;

    LineItem lineItem;
    int totalPrice = 0;
    List sharedOrder = jsonDecode(prefs.getString('order'));

    if (sharedOrder != null) {
      _lineItems.clear();
      print(sharedOrder.toString());
      sharedOrder.forEach((v) {
        lineItem = LineItem(
            image: v['product']['image_url'].toString(),
            id: v['product']['id'],
            count: v['quantity'],
            title: v['product']['title'],
            price: int.parse(v['product']['price']));

        totalPrice += int.parse(v['product']['price']);
        _lineItems.add(lineItem);
      });

      order = Order(
        totalPrice: totalPrice.toString(),
        count: _lineItems.length.toString(),
        lineItems: _lineItems,
      );

      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> changeState() async {
    // _isLoading = true;
    // notifyListeners();

    // await fetchCurrentOrder();
    // _isLoading = false;
    // notifyListeners();
    return true;
  }

  Future<bool> completeOrder(int paymentMethodId) async {
    print("COMPLETE ORDER $paymentMethodId");
    _isLoading = true;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = await getHeaders();
    print("ITEMTOTAL--------> ${order.count}");
    Map<String, dynamic> paymentPayload = {
      'payment': {
        'payment_method_id': paymentMethodId,
        'amount': order.totalPrice,
      }
    };

    _isLoading = false;
    notifyListeners();
    return true;
  }

  clearData() async {
    print("CLEAR DATA");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('orderToken', null);
    prefs.setString('orderNumber', null);
    _lineItems.clear();
    order = null;
    notifyListeners();
  }
}
