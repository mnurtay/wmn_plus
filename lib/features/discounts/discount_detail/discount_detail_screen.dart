import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmn_plus/features/discounts/discount_detail/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wmn_plus/features/discounts/discounts_state.dart';

class DiscountDetailScreen extends StatefulWidget {
  const DiscountDetailScreen({
    Key key,
    @required DiscountDetailBloc discountDetailBloc,
    String id,
  })  : _discountDetailBloc = discountDetailBloc,
        _id = id,
        super(key: key);

  final DiscountDetailBloc _discountDetailBloc;
  final String _id;

  @override
  DiscountDetailScreenState createState() {
    return DiscountDetailScreenState(_discountDetailBloc);
  }
}

class DiscountDetailScreenState extends State<DiscountDetailScreen> {
  final DiscountDetailBloc _discountDetailBloc;
  DiscountDetailScreenState(this._discountDetailBloc);

  static final List<String> imgList = [
    'https://avatars.mds.yandex.net/get-pdb/398891/2617e07a-0505-4b4d-b9ff-80ba5d8f964e/s1200?webp=false',
    'https://mir-s3-cdn-cf.behance.net/project_modules/1400/ef40c148859121.58a419031cc0d.jpg',
    'https://teficlinic.com/wp-content/uploads/slide22-1024x683.jpg',
    'https://avatars.mds.yandex.net/get-altay/1427475/2a00000168e2f84867ecc3bc87bbaf26cd59/XXL',
    'https://p2.zoon.ru/preview/YEwuzLUryK9Ee_v-GZlhkw/1180x520x85/1/e/6/original_4fafe9a43c72dd0634000012_59cb696265b98.jpg',
  ];

  final CarouselSlider autoPlayDemo = CarouselSlider(
    viewportFraction: 0.9,
    aspectRatio: 2.0,
    autoPlay: true,
    enlargeCenterPage: true,
    items: imgList.map(
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
    ).toList(),
  );
  @override
  void initState() {
    super.initState();
    widget._discountDetailBloc.add(UnDiscountDetailEvent());
    widget._discountDetailBloc.add(LoadDiscountDetailEvent(widget._id));
  }

  @override
  void dispose() {
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
              child: Column(
                children: <Widget>[
                  autoPlayDemo,
                  SizedBox(
                    height: 5,
                  ),
                  headerBox(currentState.hello.result.title),
                  SizedBox(
                    height: 5,
                  ),
                  informationBox(),
                  SizedBox(
                    height: 5,
                  ),
                  contactsBox()
                ],
              ),
            );
          }
        });
  }

  void _load([bool isError = false]) {}

  headerBox(String title) {
    return Container(
      height: 80,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Text(
              title,
              style: Theme.of(context).textTheme.display3,
            ),
            left: 10,
          ),
          Positioned(
              child: Text(
                "УЗИ",
                style: Theme.of(context).textTheme.subhead,
              ),
              left: 10,
              top: 30),
        ],
      ),
    );
  }

  informationBox() {
    return Container(
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
              "Но экономическая повестка сегодняшнего дня, в своём классическом представлении, допускает внедрение существующих финансовых и административных условий. Лишь непосредственные участники технического прогресса являются только методом политического участия и разоблачены. Таким образом, глубокий уровень погружения способствует подготовке и реализации экономической целесообразности принимаемых решений.",
              style: Theme.of(context).textTheme.subhead,
            ),
          ],
        ),
      ),
    );
  }

  contactsBox() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Контакты",
              style: Theme.of(context).textTheme.display3,
            ),
            Container(
              color: Colors.green,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "г. Алматы, ул. Кабдолова 16",
                style: Theme.of(context).textTheme.body2,
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
              child: Text("Будни: с 08:00 до 20:00"),
            ),
          ],
        ),
      ),
    );
  }
}
