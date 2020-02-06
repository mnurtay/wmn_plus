import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wmn_plus/features/ecommerce/models/category.dart';
import 'package:wmn_plus/features/ecommerce/models/option_type.dart';
import 'package:wmn_plus/features/ecommerce/models/option_value.dart';
import 'package:wmn_plus/features/ecommerce/models/product.dart';
import 'package:wmn_plus/features/ecommerce/scoped-models/main.dart';
import 'package:wmn_plus/features/ecommerce/screens/auth.dart';
import 'package:wmn_plus/features/ecommerce/screens/search.dart';
import 'package:wmn_plus/features/ecommerce/utils/connectivity_state.dart';
import 'package:wmn_plus/features/ecommerce/utils/constants.dart';
import 'package:wmn_plus/features/ecommerce/utils/drawer_homescreen.dart';
import 'package:wmn_plus/features/ecommerce/utils/locator.dart';
import 'package:wmn_plus/features/ecommerce/widgets/category_box.dart';
import 'package:wmn_plus/features/ecommerce/widgets/shopping_cart_button.dart';
import 'package:wmn_plus/features/ecommerce/models/banners.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final MainModel _model = MainModel();
  Size _deviceSize;
  Map<dynamic, dynamic> responseBody;
  bool _isBannerLoading = true;
  bool _isCategoryLoading = true;
  bool _isDealsLoading = true;
  bool _isAuthenticated = false;
  List<Product> todaysDealProducts = [];
  List<Category> categories = [];
  List<BannerImage> banners = [];
  List<String> bannerImageUrls = [];
  List<String> bannerLinks = [];
  int favCount;

  @override
  void initState() {
    super.initState();
    // getFavoritesCount();
    getCategories();
    // getTodaysDeals();
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
    _deviceSize = MediaQuery.of(context).size;
    List<Widget> actions = [];

    for (int i = 0; i < banners.length; i++) {
      actions.add(bannerCards(i));
    }

    Widget bannerCarousel = CarouselSlider(
      items: _isBannerLoading ? [bannerCards(0)] : actions,
      autoPlay: true,
      enlargeCenterPage: true,
    );
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Scaffold(
        appBar: AppBar(
          title: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Магазин',
                textAlign: TextAlign.start,
                style: TextStyle(fontFamily: 'HolyFat', fontSize: 24),
              )),
          actions: <Widget>[
            shoppingCartIconButton(),
          ],
          bottom: PreferredSize(
            preferredSize: Size(_deviceSize.width, 70),
            child: searchBar(),
          ),
        ),
        drawer: HomeDrawer(),
        body: Container(
          color: Colors.white,
          child: CustomScrollView(slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                // Container(
                //     color: Colors.grey.withOpacity(0.1), child: bannerCarousel)
              ]),
            ),
            SliverToBoxAdapter(
              child: Divider(
                height: 1.0,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  width: _deviceSize.width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.category,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text('Категории',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: fontFamily)),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            _isCategoryLoading
                ? SliverList(
                    delegate: SliverChildListDelegate([
                    Container(
                      height: _deviceSize.height * 0.5,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.purple,
                      ),
                    )
                  ]))
                : categories.length > 0
                    ? SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return categoryBox(
                              index, context, _deviceSize, categories);
                        }, childCount: categories.length),
                      )
                    : SliverList(
                        delegate: SliverChildListDelegate([
                          Container(
                            width: _deviceSize.width,
                            color: Colors.white,
                            child: Center(
                              child: Text('No items present'),
                            ),
                          ),
                        ]),
                      ),
            SliverToBoxAdapter(
              child: Container(
                height: 20.0,
                color: Colors.grey.withOpacity(0.1),
              ),
            ),
            SliverToBoxAdapter(
              child: Divider(
                height: 1.0,
              ),
            ),
            // SliverList(
            //   delegate: SliverChildListDelegate([
            //     Container(
            //         width: _deviceSize.width,
            //         color: Colors.white,
            //         child: Padding(
            //           padding: const EdgeInsets.all(12.0),
            //           child: Row(
            //             children: <Widget>[
            //               Icon(
            //                 Icons.local_offer,
            //                 color: Colors.orange,
            //               ),
            //               SizedBox(
            //                 width: 8.0,
            //               ),
            //               Text('Today\'s Deals',
            //                   style: TextStyle(
            //                       fontSize: 14,
            //                       fontWeight: FontWeight.normal,
            //                       fontFamily: fontFamily)),
            //             ],
            //           ),
            //         ))
            //   ]),
            // ),
            // _isDealsLoading
            //     ? SliverList(
            //         delegate: SliverChildListDelegate([
            //         Container(
            //           height: _deviceSize.height * 0.47,
            //           alignment: Alignment.center,
            //           child: CircularProgressIndicator(
            //             backgroundColor: Colors.green,
            //           ),
            //         )
            //       ]))
            //     : SliverToBoxAdapter(
            //         child: Container(
            //           height: 355,
            //           child: ListView.builder(
            //             scrollDirection: Axis.horizontal,
            //             itemCount: todaysDealProducts.length,
            //             itemBuilder: (context, index) {
            //               return todaysDealsCard(
            //                   index, todaysDealProducts, _deviceSize, context);
            //             },
            //           ),
            //         ),
            //       ),
            // SliverToBoxAdapter(
            //   child: Divider(),
            // ),
          ]),
        ),
        // bottomNavigationBar:
        //     !model.isAuthenticated ? bottomNavigationBar() : null,
      );
    });
  }

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (index) {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (context) => Authentication(index));

        Navigator.push(context, route);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline, color: Colors.green),
          title: Text('SIGN IN'),
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              color: Colors.green,
            ),
            title: Text('CREATE ACCOUNT',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 15,
                    fontWeight: FontWeight.w600))),
      ],
    );
  }

  Widget bannerCards(int index) {
    if (_isBannerLoading) {
      return Container(
        width: _deviceSize.width * 0.8,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          elevation: 2,
          margin: EdgeInsets.symmetric(
              vertical: _deviceSize.height * 0.05,
              horizontal: _deviceSize.width * 0.02),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              child: Image.asset(
                'images/placeholders/slider1.jpg',
                fit: BoxFit.fill,
              )),
        ),
      );
    } else {
      return GestureDetector(
          onTap: () {
            MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => ProductSearch(
                      // slug: bannerLinks[index],
                      slug: banners[index].imageSlug,
                    ));
            Navigator.of(context).push(route);
          },
          child: Container(
            width: _deviceSize.width * 0.8,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              elevation: 2,
              margin: EdgeInsets.symmetric(
                  vertical: _deviceSize.height * 0.05,
                  horizontal: _deviceSize.width * 0.02),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                child: FadeInImage(
                  image: NetworkImage(banners[index].imageUrl != null
                      ? banners[index].imageUrl
                      : ''),
                  placeholder: AssetImage('images/placeholders/slider1.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ));
    }
  }

  getCategoriess() async {
    int petsId;
    http.Response response = await http
        .get(Settings.SERVER_URL + 'api/v1/taxonomies?q[name_cont]=Pets');
    responseBody = json.decode(response.body);
    petsId = responseBody['taxonomies'][0]['id'];
    http
        .get(Settings.SERVER_URL +
            'api/v1/taxonomies?q[name_cont]=Pets&set=nested')
        .then((response) {
      responseBody = json.decode(response.body);
      responseBody['taxonomies'][0]['root']['taxons'].forEach((category) {
        setState(() {
          categories.add(Category(
              parentId: petsId,
              name: category['name'],
              image: category['icon'],
              id: category['id']));
        });
      });
      setState(() {
        _isCategoryLoading = false;
      });
    });
  }

  getCategories() async {
    http.get(Settings.API_URL + 'categorylist', headers:{
      "Authorization": "wmn538179 qwerty"
    } ).then((response) {
      responseBody = json.decode(utf8.decode(response.bodyBytes));
      responseBody['result'].forEach((category) {
        setState(() {
          categories.add(Category(
              parentId: category['id'],
              name: category['title'],
              image: category['icon'],
              id: category['id']));
        });
      });
      setState(() {
        _isCategoryLoading = false;
      });
    });
  }

 
  Widget searchBar() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return GestureDetector(
          onTap: () {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (context) => ProductSearch());
            Navigator.of(context).push(route);
          },
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)),
              width: _deviceSize.width,
              height: 49,
              margin: EdgeInsets.all(010),
              child: ListTile(
                leading: Icon(Icons.search),
                title: Text(
                  'Искать',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              ),
            ),
            model.isLoading ? LinearProgressIndicator() : Container()
          ]));
    });
  }
}
