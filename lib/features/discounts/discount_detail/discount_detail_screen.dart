import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wmn_plus/features/discounts/discount_detail/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wmn_plus/features/discounts/discounts_state.dart';

class DiscountDetailScreen extends StatefulWidget {
  const DiscountDetailScreen({
    Key key,
    @required DiscountDetailBloc discountDetailBloc,
    @required Map<String, int> route,
  })  : _discountDetailBloc = discountDetailBloc,
        _route = route,
        super(key: key);

  final DiscountDetailBloc _discountDetailBloc;
  final Map<String, int> _route;

  @override
  DiscountDetailScreenState createState() {
    return DiscountDetailScreenState(_discountDetailBloc);
  }
}

class DiscountDetailScreenState extends State<DiscountDetailScreen>
    with TickerProviderStateMixin {
  final DiscountDetailBloc _discountDetailBloc;
  DiscountDetailScreenState(this._discountDetailBloc);
  TabController tabController;

  CarouselSlider autoPlayDemo(List<String> list) {
    return CarouselSlider(
        viewportFraction: 0.9,
        aspectRatio: 2.0,
        autoPlay: true,
        enlargeCenterPage: true,
        items: list.map(
          (url) {
            return Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  width: 1000.0,
                ),
              ),
            );
          },
        ).toList());
  }

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
    widget._discountDetailBloc.add(UnDiscountDetailEvent());
    widget._discountDetailBloc.add(LoadDiscountDetailEvent(widget._route));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountDetailBloc, DiscountDetailState>(
        bloc: widget._discountDetailBloc,
        builder: (
          BuildContext context,
          DiscountDetailState currentState,
        ) {
          if (currentState is UnDiscountDetailState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorDiscountDetailState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ?? 'Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text("reload"),
                    onPressed: () => this._load(),
                  ),
                ),
              ],
            ));
          }
          if (currentState is InDiscountDetailState) {
            return SingleChildScrollView(
              child: Container(
                color: Colors.grey.withOpacity(0.2),
                child: Column(
                  children: <Widget>[
                    autoPlayDemo(currentState.hello.result.images),
                    SizedBox(
                      height: 5,
                    ),
                    headerBox(currentState.hello.result.title,
                        currentState.hello.result.content),
                    SizedBox(
                      height: 5,
                    ),
                    // buildTab(),
                    buildProperties(
                      currentState.hello.result.properties,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    buildConditions(currentState.hello.result.conditions),
                    SizedBox(
                      height: 7,
                    ),
                    contactsBox(currentState.hello.result.address,
                        currentState.hello.result.workdays)
                  ],
                ),
              ),
            );
          }
        });
  }

  buildTab() {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
            controller: tabController,
            tabs: <Widget>[
              Tab(
                child: Text(
                  "Oсобенности",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Условия",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          // _buildDivider(MediaQuery.of(context).size),
        ],
      ),
    );
  }

  buildProperties(String properties) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Особенности",
              style: Theme.of(context).textTheme.display3,
            ),
            Html(
              data: properties.trim(),
            ),
          ],
        ),
      ),
    );
  }

  buildConditions(String conditions) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Условия",
              style: Theme.of(context).textTheme.display3,
            ),
            Html(data: conditions.trim()),
          ],
        ),
      ),
    );
  }

  void _load([bool isError = false]) {}

  headerBox(String title, String desc) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title.trim(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              desc.trim(),
              style: Theme.of(context).textTheme.subhead,
            ),
          ],
        ),
      ),
    );
  }

  informationBox(String content) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Информация",
              style: Theme.of(context).textTheme.display3,
            ),
            Text(
              content,
              style: Theme.of(context).textTheme.subhead,
            ),
          ],
        ),
      ),
    );
  }

  contactsBox(String address, String workTime) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                address,
                style: Theme.of(context).textTheme.body1,
              ),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Html(
                  data: workTime,
                )),
          ],
        ),
      ),
    );
  }
}
