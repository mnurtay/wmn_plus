import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wmn_plus/features/ecommerce/models/category.dart';
import 'package:wmn_plus/features/ecommerce/models/option_type.dart';
import 'package:wmn_plus/features/ecommerce/models/option_value.dart';
import 'package:wmn_plus/features/ecommerce/models/product.dart';
import 'package:wmn_plus/features/ecommerce/scoped-models/main.dart';
import 'package:wmn_plus/features/ecommerce/screens/search.dart';
import 'package:wmn_plus/features/ecommerce/utils/color_list.dart';
import 'package:wmn_plus/features/ecommerce/utils/connectivity_state.dart';
import 'package:wmn_plus/features/ecommerce/utils/constants.dart';
import 'package:wmn_plus/features/ecommerce/utils/drawer_homescreen.dart';
import 'package:wmn_plus/features/ecommerce/utils/locator.dart';
import 'package:wmn_plus/features/ecommerce/widgets/product_container.dart';
import 'package:wmn_plus/features/ecommerce/widgets/shopping_cart_button.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:wmn_plus/features/ecommerce/utils/headers.dart';

class CategoryListing extends StatefulWidget {
  final String categoryName;
  final int categoryId;
  final int parentId;

  CategoryListing(this.categoryName, this.categoryId, this.parentId);
  @override
  State<StatefulWidget> createState() {
    return _CategoryListingState();
  }
}

class _CategoryListingState extends State<CategoryListing> {
  Size _deviceSize;
  bool _isLoading = true;
  int level = 1;
  static const int PAGE_SIZE = 20;
  List<Category> categoryList = [];
  List<Category> subCategoryList = [];
  List<Product> productsByCategory = [];
  List<Widget> header = [];
  final int perPage = TWENTY;
  int currentPage = ONE;
  int subCatId = ZERO;
  int currentIndex = -1;
  int totalCount = 0;
  List<Widget> subCatList = [];
  final scrollController = ScrollController();
  bool hasMore = false, isFilterDataLoading = false;
  bool isChecked = false;
  List<Category> filterSubCategoryList = [];
  final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>(); // ADD THIS LINE
  Map<dynamic, dynamic> responseBody;
  List<Category> _listViewData = [];
  String sortBy = '';
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentItem;
  String _currentCategory = '';
  int _currentCatIndex;
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
            // style: TextStyle(color: Colors.red),
          )));
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
        getProductsBySubCategory();
      }
    });

    header.add(mainPageTextField());
    header
        .add(textField(widget.categoryName, FontWeight.w300, 0, Colors.white));
    getSubCategory(widget.parentId);
    locator<ConnectivityManager>().initConnectivity(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    locator<ConnectivityManager>().dispose();
  }

  void getSubCatList(int categoryId, String catName) async {
    setState(() {
      isFilterDataLoading = true;
    });
    if (currentIndex >= 0) {
      _listViewData = [];
      await http
          .get(Settings.SERVER_URL +
              'api/v1/taxonomies/${widget.parentId}/taxons/$categoryId')
          .then((response) {
        responseBody = json.decode(response.body);
        responseBody['taxons'].forEach((category) {
          _listViewData.add(Category(
            id: category['id'],
            name: category['name'],
            parentId: widget.parentId,
          ));
        });
      });
    }
    List<Widget> subCatList = [];
    for (Category cat in _listViewData) {
      print('Data');
      subCatList.add(InkWell(
        onTap: () {
          setState(() {
            productsByCategory = [];
            subCatId = cat.id;
            Navigator.pop(context);
            adjustHeaders(cat.name);
            loadProductsByCategory();
          });
        },
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(cat.name),
            ),
            Divider(),
          ],
        ),
      ));
    }
    setState(() {
      isFilterDataLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return WillPopScope(
        onWillPop: () => _canLeave(),
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text('Магазин'),
              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => ProductSearch());
                    Navigator.of(context).push(route);
                  },
                ),
                shoppingCartIconButton()
              ],
            ),
            drawer: HomeDrawer(),
            // endDrawer: filterDrawer(),
            body: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: !_isLoading ? body(level) : Container(),
                ),
                Container(
                  color: Colors.purpleAccent,
                  height: 59.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          left: 30,
                        ),
                        height: 30.0,
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              headerRow(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: model.isLoading || _isLoading
                      ? LinearProgressIndicator()
                      : Container(),
                ),
                level == 2
                    // ? Container(
                    //     padding: EdgeInsets.only(right: 20.0, top: 30.0),
                    //     alignment: Alignment.topRight,
                    //     child: FloatingActionButton(
                    //       onPressed: () {
                    //         _scaffoldKey.currentState.openEndDrawer();
                    //       },
                    //       child: Icon(
                    //         Icons.filter_list,
                    //         color: Colors.white,
                    //       ),
                    //       backgroundColor: Colors.orange,
                    //     ),
                    //   )
                    ? Container()
                    : Container(),
              ],
            )),
      );
    });
  }

  Widget filterDrawer() {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 3.0,
            child: Container(
                alignment: Alignment.centerLeft,
                color: Colors.orange,
                height: 150.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      title: Row(
                        children: <Widget>[
                          Text(
                            'Sort By:  ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18.0),
                          ),
                          DropdownButton(
                            underline: Container(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal),
                            value: null,
                            hint: Text(
                              _currentItem,
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white60,
                            ),
                            items: _dropDownMenuItems,
                            onChanged: changedDropDownItem,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                      child: Text(
                        '$totalCount Results',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )),
          ),
          categoryDropDown(),
          Divider(
            height: 1.0,
            color: Colors.grey,
            indent: 10.0,
          ),
        ],
      ),
    );
  }

  Widget categoryDropDown() {
    return Expanded(
      child: Theme(
        data: ThemeData(primarySwatch: Colors.green),
        child: ListView(
          children: [
            ExpansionTile(
                initiallyExpanded: true,
                onExpansionChanged: (value) {
                  if (value) {}
                },
                title: Text(_currentCategory),
                children: subCatList)
          ],
        ),
      ),
    );
  }

  List<Widget> progressBar() {
    List<Widget> progressBar = [];
    progressBar.add(
      CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),
    );
    return progressBar;
  }

  List<Widget> emptyWidget() {
    List<Widget> widgetList = [];
    widgetList.add(Container());
    return widgetList;
  }

  Widget body(int level) {
    switch (level) {
      case 0:
        return (categoryList.length == 0)
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0),
                child: Center(
                  child: Text(
                    'No Product Found',
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return getCategoryBox(index, level);
                  },
                  itemCount: categoryList.length,
                ),
              );

        break;
      case 1:
        return (subCategoryList.length == 0)
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0),
                child: Center(
                  child: Text(
                    'No Product Found',
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return getCategoryBox(index, level);
                  },
                  itemCount: subCategoryList.length,
                ),
              );

        break;
      case 2:
        return Theme(
          data: ThemeData(primarySwatch: Colors.green),
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: ListView.builder(
                controller: scrollController,
                itemCount: productsByCategory.length,
                itemBuilder: (context, index) {
                  if (index < productsByCategory.length) {
                    return productContainer(
                        context, productsByCategory[index], index);
                  }
                  if (productsByCategory.length == 0) {
                    print("LENGTH 00000000");
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.0),
                      child: Center(
                        child: Text(
                          'Продуктов не существуют',
                          style: TextStyle(fontSize: 20.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  if (!hasMore) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 25.0),
                      child: Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      )),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
        );
        break;
      default:
        return Container();
    }
  }

  Widget headerRow() {
    return Row(
      children: header,
    );
  }

  Widget mainPageTextField() {
    return GestureDetector(
        onTap: () {
          setState(() {
            Navigator.popUntil(context, ModalRoute.withName('/home'));
          });
        },
        child: Row(
          children: <Widget>[
            Text("Главная",
                style: TextStyle(
                    color: Colors.white60,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white60,
                  size: 16,
                )),
          ],
        ));
  }

  Widget textField(
      String text, FontWeight fontWeight, int categoryLevel, Color textColor) {
    int sublevel;
    print("LEVEL ${level == 2} BUILDING TEXTFIELD $text");

    return GestureDetector(
        onTap: () {
          sublevel = level - categoryLevel - 1;
          setState(() {
            for (int i = 0; i < sublevel; i++) {
              header.removeLast();
            }
            level = level - sublevel;
          });
          // print("LEVEL $level BUILDING TEXTFIELD $text");
        },
        child: Text(
          text,
          style: TextStyle(
              color: level == 2 ? Colors.white : Colors.white70,
              fontSize: 18,
              fontWeight: level == 2 ? FontWeight.w500 : fontWeight),
        ));
  }

  Widget getCategoryBox(int index, int level) {
    return GestureDetector(
        onTap: () {
          if (level == 0) {
            getSubCategory(categoryList[index].id);
            setState(() {
              _currentCategory = categoryList[index].name;
              _currentCatIndex = categoryList[index].id;
              header.add(Row(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white60,
                        size: 16,
                      )),
                  textField(categoryList[index].name, FontWeight.w100, 1,
                      Colors.white)
                ],
              ));
            });
          } else {
            subCatId = subCategoryList[index].id;
            loadProductsByCategory();
            setState(() {
              header.add(Row(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white60,
                        size: 16,
                      )),
                  textField(subCategoryList[index].name, FontWeight.w100, 2,
                      Colors.white)
                ],
              ));
            });
          }
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          width: _deviceSize.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: colorList[index],
          ),
          child: Text(
            level == 0 ? categoryList[index].name : subCategoryList[index].name,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ));
  }

  void adjustHeaders(String subCatName) {
    setState(() {
      header.removeLast();
      setState(() {
        header.add(Row(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white60,
                  size: 16,
                )),
            textField(subCatName, FontWeight.w100, 2, Colors.white)
          ],
        ));
      });
    });
  }

  getCategory() {
    categoryList = [];
    http
        .get(Settings.SERVER_URL +
            'api/v1/taxonomies/${widget.parentId}/taxons/${widget.categoryId}')
        .then((response) {
      responseBody = json.decode(response.body);
      responseBody['taxons'].forEach((category) {
        categoryList.add(Category(
            id: category['id'],
            name: category['name'],
            parentId: widget.parentId));
      });
      setState(() {
        _isLoading = false;
        level = 0;
      });
    });
  }

  getSubCategory(int categoryId) {
    setState(() {
      _isLoading = true;
      isFilterDataLoading = true;
      subCategoryList = [];
      subCatList = [];
    });
    http.get(Settings.API_URL + 'subcategorylist/$categoryId',
        headers: {"Authorization": "wmn538179 qwerty"}).then((response) {
      responseBody = json.decode(utf8.decode(response.bodyBytes));
      print(responseBody);
      responseBody['result'].forEach((category) {
        subCategoryList.add(Category(
            id: category['id'],
            name: category['title'],
            parentId: widget.parentId));
      });
      for (Category cat in subCategoryList) {
        print(cat.id);
        subCatList.add(InkWell(
          onTap: () {
            setState(() {
              productsByCategory = [];
              subCatId = cat.id;
              Navigator.pop(context);
              adjustHeaders(cat.name);
              loadProductsByCategory();
            });
          },
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(cat.name),
              ),
              // Divider(),
            ],
          ),
        ));
      }
      setState(() {
        level = 1;
        _isLoading = false;
        isFilterDataLoading = false;
      });
    });
  }

  void getProductsBySubCategory() async {
    http.get(Settings.API_URL + 'productslist/${widget.parentId}/$subCatId',
        headers: {"Authorization": "wmn538179 qwerty"}).then((response) {
      responseBody = json.decode(utf8.decode(response.bodyBytes));
      print(Settings.API_URL + 'productslist/${widget.parentId}/$subCatId');
      print(responseBody.toString());
      responseBody['result'].forEach((product) {
        setState(() {
          productsByCategory.add(Product(
            id: product['id'],
            subCatId: subCatId,
            catId: widget.parentId,
            image: "http://194.146.43.98:4000/image?uri=" +
                product['image_urls'][0],
            currencySymbol: "KZT",
            title: product['title'],
            price: product['price'].toString(),
          ));
        });
      });

    });
  }

  void loadProductsByCategory([String sortBy]) {
    setState(() {
      currentPage = ONE;
      productsByCategory = [];
      this.sortBy = sortBy;
      getProductsBySubCategory();
      // getProductsByCategory();
      level = 2;
      _isLoading = false;
    });
  }

  Future<bool> _canLeave() {
    if (level == 0) {
      return Future<bool>.value(true);
    } else {
      setState(() {
        level = level - 1;
        header.removeLast();
      });
      return Future<bool>.value(false);
    }
  }

  void changedDropDownItem(String selectedCity) {
    String sortingWith = '';
    setState(() {
      _currentItem = selectedCity;
      switch (_currentItem) {
        case 'Newest':
          sortingWith = 'updated_at+asc';
          break;
        case 'Avg.Customer Review':
          sortingWith = 'avg_rating+desc ';
          break;
        case 'Most Reviews':
          sortingWith = 'reviews_count+desc';
          break;
        case 'A TO Z':
          sortingWith = 'name+asc';
          break;
        case 'Z TO A':
          sortingWith = 'name+desc';
          break;
      }

      loadProductsByCategory(sortingWith);
    });
  }
}
