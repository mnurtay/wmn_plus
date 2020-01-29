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

  Order get getOrder {
    return order;
  }

  Future<Order> getOrderFuture() async {
    var shared = await SharedPreferences.getInstance();
    String orderString = shared.getString('order');
    Order order = jsonDecode(orderString);
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
          avgRating: 5.0,
          displayPrice: responseBody['result']['price'].toString(),
          hasVariants: false,
          description: responseBody['result']['description'],
          title: responseBody['result']['title'],
          favoritedByUser: false,
          id: responseBody['result']['id'],
          totalOnHand: 10,
          reviewProductId: 0,
          reviewsCount: "0",
          taxonId: 14,
          isOrderable: true,
          isBackOrderable: true,
          name: "",
          image: "http://194.146.43.98:4000/image?uri=" +
              responseBody['result']['image_urls'][0],
          price: responseBody['result']['price'].toString(),
          costPrice: responseBody['result']['price'].toString());

      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => ProductDetailScreen(prod));
      if (isSimilarListing) Navigator.pop(context);
      Navigator.push(context, route);
      _isLoading = false;
      notifyListeners();
    });
  }

  void getProductDetail(String slug, BuildContext context,
      [bool isSimilarListing = false]) async {
    Map<String, String> headers = await getHeaders();
    Map<String, dynamic> responseBody = Map();
    Product tappedProduct = Product();
    _isLoading = true;
    notifyListeners();
    // setLoading(true);
    print(
        "PRODUCT SLUG ------> ${Settings.SERVER_URL + 'api/v1/products/$slug?data_set=large'}}");
    http.Response response = await http.get(
        Settings.SERVER_URL + 'api/v1/products/$slug?data_set=large',
        headers: headers);

    responseBody = json.decode(response.body);

    List<Product> variants = [];
    List<OptionValue> optionValues = [];
    List<OptionType> optionTypes = [];

    int reviewProductId = responseBody['data']['attributes']["id"];
    variants = [];
    if (responseBody['data']['attributes']['has_variants']) {
      responseBody['data']['included']['variants'].forEach((variant) {
        print(
            "TOTAL ON HAND ${variant['data']['attributes']['total_on_hand']}");
        optionValues = [];
        optionTypes = [];
        variant['data']['included']['option_values'].forEach((option) {
          optionValues.add(OptionValue(
            id: option['data']['attributes']['id'],
            name: option['data']['attributes']['name'],
            optionTypeId: option['data']['attributes']['option_type_id'],
            optionTypeName: option['data']['attributes']['option_type_name'],
            optionTypePresentation: option['data']['attributes']
                ['option_type_presentation'],
          ));
        });
        variants.add(Product(
            favoritedByUser: responseBody['data']['attributes']
                ['is_favorited_by_current_user'],
            id: variant['data']['attributes']['id'],
            name: variant['data']['attributes']['name'],
            description: variant['data']['attributes']['description'],
            optionValues: optionValues,
            displayPrice: variant['data']['attributes']['display_price'],
            price: variant['data']['attributes']['price'],
            currencySymbol: responseBody['data']['attributes']
                ['currency_symbol'],
            costPrice: variant['data']['attributes']['cost_price'],
            image: variant['data']['included']['images'][0]['data']
                ['attributes']['product_url'],
            isOrderable: variant['data']['attributes']['is_orderable'],
            isBackOrderable: variant['data']['attributes']['is_backorderable'],
            avgRating:
                double.parse(responseBody['data']['attributes']['avg_rating']),
            reviewsCount:
                responseBody['data']['attributes']['reviews_count'].toString(),
            totalOnHand: variant['data']['attributes']['total_on_hand'],
            reviewProductId: reviewProductId));
      });
      responseBody['data']['included']['option_types'].forEach((optionType) {
        optionTypes.add(OptionType(
            id: optionType['data']['attributes']['id'],
            name: optionType['data']['attributes']['name'],
            position: optionType['data']['attributes']['position'],
            presentation: optionType['data']['attributes']['presentation']));
      });
      tappedProduct = Product(
        favoritedByUser: responseBody['data']['attributes']
            ['is_favorited_by_current_user'],
        name: responseBody['data']['attributes']['name'],
        displayPrice: responseBody['data']['attributes']['display_price'],
        currencySymbol: responseBody['data']['attributes']['currency_symbol'],
        price: responseBody['data']['attributes']['price'],
        costPrice: responseBody['data']['attributes']['cost_price'],
        avgRating:
            double.parse(responseBody['data']['attributes']['avg_rating']),
        reviewsCount:
            responseBody['data']['attributes']['reviews_count'].toString(),
        image: responseBody['data']['included']['master']['data']['included']
            ['images'][0]['data']['attributes']['product_url'],
        variants: variants,
        reviewProductId: reviewProductId,
        hasVariants: responseBody['data']['attributes']['has_variants'],
        optionTypes: optionTypes,
        taxonId: responseBody['data']['attributes']['taxon_ids'].first,
      );
    } else {
      tappedProduct = Product(
        favoritedByUser: responseBody['data']['attributes']
            ['is_favorited_by_current_user'],
        id: responseBody['data']['included']['id'],
        name: responseBody['data']['attributes']['name'],
        displayPrice: responseBody['data']['attributes']['display_price'],
        price: responseBody['data']['attributes']['price'],
        currencySymbol: responseBody['data']['attributes']['currency_symbol'],
        costPrice: responseBody['data']['attributes']['cost_price'],
        avgRating:
            double.parse(responseBody['data']['attributes']['avg_rating']),
        reviewsCount:
            responseBody['data']['attributes']['reviews_count'].toString(),
        image: responseBody['data']['included']['master']['data']['included']
            ['images'][0]['data']['attributes']['product_url'],
        hasVariants: responseBody['data']['attributes']['has_variants'],
        totalOnHand: responseBody['data']['attributes']['total_on_hand'],
        isOrderable: responseBody['data']['included']['master']['data']
            ['attributes']['is_orderable'],
        isBackOrderable: responseBody['data']['included']['master']['data']
            ['attributes']['is_backorderable'],
        reviewProductId: reviewProductId,
        description: responseBody['data']['attributes']['description'],
        taxonId: responseBody['data']['attributes']['taxon_ids'].first,
      );
    }

    MaterialPageRoute route = MaterialPageRoute(
        builder: (context) => ProductDetailScreen(tappedProduct));
    if (isSimilarListing) Navigator.pop(context);
    Navigator.push(context, route);
    _isLoading = false;
    notifyListeners();
  }

  void addProduct({Product product, int quantity}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("quantity $quantity");

    _lineItems.clear();
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

  void removeProduct(int lineItemId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoading = true;
    _lineItems.clear();
    notifyListeners();
    http
        .delete(Settings.SERVER_URL +
            'api/v1/orders/${prefs.getString('orderNumber')}/line_items/$lineItemId?order_token=${prefs.getString('orderToken')}')
        .then((response) {
      fetchCurrentOrder();
    });
  }

  void createNewOrder(Product product, int quantity) async {
    Map<dynamic, dynamic> orderParams = Map();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    orderParams = {
      'order': {
        '${product.id}': {'product': product.toJson(), 'quantity': quantity}
      }
    };

    print(orderParams.toString());

    prefs.setString('order', jsonEncode(orderParams));
  }

  void createNewLineItem(Product product, int quantity) async {
    print("CREATING NEW LINEITEM");
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    lineItemObject = {
      '${product.id}': {
        'product': jsonEncode(product.toJson()),
        'quantity': quantity
      }
    };

    Map order = jsonDecode(prefs.getString('order'));
    order['order'].putIfAbsent('${product.id}', () => lineItemObject);
    print(order.toString());
  }

  Future<bool> fetchCurrentOrder() async {
    print("FETCH CURRENT ORDER");
    _isLoading = true;

    LineItem lineItem;
    Variant variant;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map sharedOrder = jsonDecode(prefs.getString('order'));
    print(order);
    _lineItems.clear();
    sharedOrder['order'].forEach((k, v) {
      variant = Variant(
          image: v['product']['image_url'],
          displayPrice: v['product']['price'].toString(),
          name: v['product']['title'],
          quantity: v['quantity'],
          isBackOrderable: false,
          totalOnHand: 10);

      lineItem = LineItem(
          id: v['product']['id'],
          displayAmount: v['quantity'].toString(),
          quantity: v['quantity'],
          total: v['quantity'].toString(),
          variant: variant,
          variantId: 0);
      _lineItems.add(lineItem);
    });

    order = Order(
      total: "1234",
      id: 122,
      itemTotal: "33",
      lineItems: _lineItems,
      totalQuantity: 10,
    );
    print(getOrder.totalQuantity);
    prefs.setString('numberOfItems', _lineItems.length.toString());
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> changeState() async {
    _isLoading = true;
    notifyListeners();

    order = Order(
      total: "1234",
      id: 122,
      itemTotal: "33",
      lineItems: _lineItems,
      totalQuantity: 10,
    );

    await fetchCurrentOrder();
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> completeOrder(int paymentMethodId) async {
    print("COMPLETE ORDER $paymentMethodId");
    _isLoading = true;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = await getHeaders();
    print("ITEMTOTAL--------> ${order.itemTotal}");
    Map<String, dynamic> paymentPayload = {
      'payment': {
        'payment_method_id': paymentMethodId,
        'amount': order.total,
      }
    };
    http.Response response = await http.post(
        Settings.SERVER_URL +
            'api/v1/orders/${prefs.getString('orderNumber')}/payments?order_token=${prefs.getString('orderToken')}',
        body: json.encode(paymentPayload),
        headers: headers);
    print(json.decode(response.body));
    _isLoading = false;
    notifyListeners();
    return true;
  }

  getPaymentMethods() async {
    _paymentMethods = [];
    _isLoading = true;
    notifyListeners();
    Map<dynamic, dynamic> responseBody;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = await getHeaders();
    http.Response response = await http.get(
        Settings.SERVER_URL +
            'api/v1/orders/${prefs.getString('orderNumber')}/payments/new?order_token=${prefs.getString('orderToken')}',
        headers: headers);
    responseBody = json.decode(response.body);
    print("GET PAYMENT METHODS RESPONSE -------> $responseBody");
    responseBody['payment_methods'].forEach((paymentMethodObj) {
      if (paymentMethodObj['name'] == 'Payubiz' ||
          paymentMethodObj['name'] == 'COD') {
        _paymentMethods.add(PaymentMethod(
            id: paymentMethodObj['id'], name: paymentMethodObj['name']));
        notifyListeners();
      }
    });
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

  Future<bool> shipmentAvailability({String pincode}) async {
    Map<String, dynamic> responseBody = Map();
    Map<String, String> headers = await getHeaders();
    Map<String, String> params = {'pincode': pincode};
    http.Response response = await http.post(
        Settings.SERVER_URL + 'address/shipment_availability',
        headers: headers,
        body: json.encode(params));
    responseBody = json.decode(response.body);
    return responseBody['available'];
  }

  Future<Map<String, dynamic>> promoCodeApplied({String promocode}) async {
    Map<String, dynamic> responseBody = Map();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = await getHeaders();
    Map<String, String> params = {
      'order_token': prefs.getString('orderToken'),
      'coupon_code': promocode
    };
    http.Response response = await http.put(
        Settings.SERVER_URL +
            'api/v1/orders/${prefs.getString('orderNumber')}/apply_coupon_code',
        headers: headers,
        body: json.encode(params));
    responseBody = json.decode(response.body);
    return responseBody;
  }

  Future<Map<String, dynamic>> promoCodeRemoved({String promocode}) async {
    Map<String, dynamic> responseBody = Map();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = await getHeaders();
    Map<String, String> params = {
      'order_token': prefs.getString('orderToken'),
      'coupon_code': promocode
    };
    http.Response response = await http.put(
        Settings.SERVER_URL +
            'api/v1/orders/${prefs.getString('orderNumber')}/remove_coupon_code',
        headers: headers,
        body: json.encode(params));
    responseBody = json.decode(response.body);
    print("PROMO CODE REMOVE RESPONSE $responseBody");
    return responseBody;
  }
}
