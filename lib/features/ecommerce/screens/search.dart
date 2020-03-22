import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wmn_plus/features/ecommerce/models/brand.dart';
import 'package:wmn_plus/features/ecommerce/models/category.dart';
import 'package:wmn_plus/features/ecommerce/models/product.dart';
import 'package:wmn_plus/features/ecommerce/scoped-models/main.dart';
import 'package:wmn_plus/features/ecommerce/utils/connectivity_state.dart';
import 'package:wmn_plus/features/ecommerce/utils/constants.dart';
import 'package:wmn_plus/features/ecommerce/utils/headers.dart';
import 'package:wmn_plus/features/ecommerce/utils/locator.dart';
import 'package:wmn_plus/features/ecommerce/widgets/product_container.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductSearch extends StatefulWidget {
  final String slug;
  ProductSearch({this.slug});
  @override
  State<StatefulWidget> createState() {
    return _ProductSearchState();
  }
}

class _ProductSearchState extends State<ProductSearch> {
  String slug = '';
  TextEditingController _controller = TextEditingController();
  // List<SearchProduct> searchProducts = [];
  List<Product> searchProducts = [];
  bool _isLoading = false;
  Product tappedProduct = Product();
  final int perPage = TWENTY;
  int currentPage = ONE;
  int subCatId = ZERO;
  bool isSearched = false;
  Size _deviceSize;
  int totalCount = 0;
  static const int PAGE_SIZE = 20;
  final scrollController = ScrollController();
  bool hasMore = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Category> _listViewData = [];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentItem;
  Map<dynamic, dynamic> responseBody;
  List<Brand> brands = [];
  List<Product> productsByBrand = [];
  String sortBy = '';
  List filterItems = [
    "Newest",
    "Avg.Customer Review",
    "Most Reviews",
    "A TO Z",
    "Z TO A"
  ];
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in filterItems) {
      items.add(new DropdownMenuItem(
        value: city,
        child: Text(
          city,
        ),
      ));
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
    sortBy = '';
    _dropDownMenuItems = getDropDownMenuItems();
    _currentItem = _dropDownMenuItems[0].value;

    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        searchProduct();
      }
    });
    locator<ConnectivityManager>().initConnectivity(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    locator<ConnectivityManager>().dispose();
  }

  @override
  Widget build(BuildContext mainContext) {
    _deviceSize = MediaQuery.of(mainContext).size;
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 1.0,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Container(
              padding: EdgeInsets.only(left: 15),
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  setState(() {
                    slug = value;
                  });
                },
                onSubmitted: (value) {
                  isSearched = true;
                  searchProducts = [];
                  currentPage = 1;
                  searchProduct();
                  // print("ENTER PRESSED ------> $value");
                },
                autofocus: true,
                decoration: InputDecoration(
                    hintText: 'Поиск',
                    border: InputBorder.none,
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 18)),
              ),
            ),
            actions: <Widget>[
              Visibility(
                visible: slug != null && slug.isNotEmpty,
                child: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                      slug = '';
                      setState(() {
                        searchProducts.clear();
                      });
                    });
                  },
                ),
              ),
            ],
          ),
          body: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 90.0),
                child: isSearched && !model.isLoading
                    ? Theme(
                        data: ThemeData(primarySwatch: Colors.green),
                        child: ListView.builder(
                            controller: scrollController,
                            itemCount: searchProducts.length + 1,
                            itemBuilder: (mainContext, index) {
                              if (index < searchProducts.length) {
                                return productContainer(
                                    _scaffoldKey.currentContext,
                                    searchProducts[index],
                                    index);
                              }
                              if (hasMore && searchProducts.length == 0) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 50.0),
                                  child: Center(
                                    child: Text(
                                      'Продуктов нету',
                                      style: TextStyle(fontSize: 20.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }
                              if (model.isLoading) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 25.0),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    backgroundColor: Colors.purple,
                                  )),
                                );
                              } else {
                                return Container();
                              }
                            }),
                      )
                    : Container(),
              ),
              Visibility(
                  visible: searchProducts.length > 0,
                  child: Material(
                    elevation: 2.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      height: 50.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 16.0),
                        child: Text(
                          'Найдено $totalCount',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                    ),
                  )),
            ],
          ));
    });
  }

  Future<List<Product>> searchProduct() async {
    _isLoading = true;
    Map<String, String> headers = await getHeaders();
    Map<String, dynamic> responseBody = Map();

    Map body = {"query": slug};
    int count = 0;
    http.Response response;
    response = await http.post(
        'http://194.146.43.98:4000/api/v1/patient/searchProduct',
        headers: headers,
        body: jsonEncode(body));
    responseBody = json.decode(response.body);
    print(responseBody);

    try {
      responseBody['result']?.forEach((searchObj) {
        searchProducts.add(Product(
          catId: searchObj['category_id'],
          subCatId: searchObj['subcategory_id'],
          description: searchObj['description'],
          title: searchObj['title'],
          id: searchObj['id'],
          image: "http://194.146.43.98:4000/image?uri=" +
              searchObj['image_urls'][0],
          price: searchObj['price'].toString(),
        ));
        count++;
      });
      setState(() {
        hasMore = false;
        totalCount = count;
        _isLoading = false;
      });

      print(hasMore);
      print(searchProducts.length);

      return searchProducts;
    } catch (e) {
      setState(() {
        hasMore = false;
        totalCount = 0;
        _isLoading = false;
      });
      return [];
    }
  }
}
