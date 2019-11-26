import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/discounts/index.dart';

class DiscountsScreen extends StatefulWidget {
  const DiscountsScreen({
    Key key,
    @required DiscountsBloc discountsBloc,
  })  : _discountsBloc = discountsBloc,
        super(key: key);

  final DiscountsBloc _discountsBloc;

  @override
  DiscountsScreenState createState() {
    return DiscountsScreenState(_discountsBloc);
  }
}

class DiscountsScreenState extends State<DiscountsScreen> {
  final DiscountsBloc _discountsBloc;
  DiscountsScreenState(this._discountsBloc);

  List<String> _category = [
    'Школы для беременных',
    'Лабораторная/инструментальная диагностика',
    'Массаж для взрослых и детей',
    'Спа центры',
    'Салоны красоты',
    'Кафе/рестораны',
    'Фитнес центры',
    'После родов',
    'Прочее'
  ];
  String _selectedCategory;
  int _categoryPosition = 0;

  @override
  void initState() {
    super.initState();
    widget._discountsBloc.add(LoadDiscountsEvent(0));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance =
        ScreenUtil(width: 828, height: 1792, allowFontScaling: true)
          ..init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(ScreenUtil.getInstance().setHeight(30)),
          child: DropdownButton(
            hint: Text('Выбрать категорию'),
            value: _selectedCategory,
            onChanged: (newValue) {
              setState(() {
                for (int i = 0; i < _category.length; i++) {
                  if (newValue == _category[i]) {
                    _categoryPosition = i;
                    _discountsBloc.add(LoadDiscountsEvent(i));
                  }
                }
                _selectedCategory = newValue;
              });
            },
            items: _category.map((location) {
              return DropdownMenuItem(
                child: new Text(location),
                value: location,
              );
            }).toList(),
          ),
        ),
        BlocBuilder<DiscountsBloc, DiscountsState>(
            bloc: widget._discountsBloc,
            builder: (
              BuildContext context,
              DiscountsState currentState,
            ) {
              if (currentState is UnDiscountsState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (currentState is ErrorDiscountsState) {
                return Center();
              }
              if (currentState is InDiscountsState) {
                return new Expanded(
                  child: new ListView.builder(
                    padding: EdgeInsets.all(
                        ScreenUtil.getInstance().setHeight(50)),
                    itemCount: currentState.discount.result.length,
                    itemBuilder: (context, index) {
                      // return buildItem(context);
                      return buildDiscountItem(
                          context, currentState.discount.result[index]);
                    },
                  ),
                );
              }
            }),
      ],
    );
  }

  Widget buildItem(BuildContext context) {
    return Container(height: 100, color: Colors.red);
  }

  Widget buildDiscountItem(
    BuildContext context,
    Result result,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/discount_detail');
      },
      child: Container(
          margin:
              EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(25)),
          height: ScreenUtil.getInstance().setHeight(700),
          width: MediaQuery.of(context).size.width,
          child: Container(
            alignment: Alignment.bottomLeft,
            child: Container(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Text(
                        result.title,
                        style: Theme.of(context).textTheme.body2,
                      ),
                      top: 10,
                      left: 10,
                    ),
                    Positioned(
                      child: Text(
                        result.content,
                        style: Theme.of(context).textTheme.display2,
                      ),
                      top: 35,
                      left: 10,
                    ),
                    Positioned(
                      child: Text("Пользуются: 99",
                          style: Theme.of(context).textTheme.display2),
                      top: 65,
                      left: 10,
                    ),
                    Positioned(
                      child: Text("от 1 100 тг.",
                          style: Theme.of(context).textTheme.display3),
                      bottom: 30,
                      right: 10,
                    ),
                    Positioned(
                      child: Text("экономия от 2500 тг.",
                          style: Theme.of(context).textTheme.display2),
                      bottom: 10,
                      right: 10,
                    ),
                  ],
                ),
                height: ScreenUtil.getInstance().setHeight(250),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)))),
            decoration: BoxDecoration(
                color: Colors.black38, borderRadius: BorderRadius.circular(10)),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(result.imageUrl)))),
    );
  }
}
