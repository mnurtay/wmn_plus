import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/discounts/index.dart';
import 'package:wmn_plus/features/discounts/widgets/discount_item.dart';

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
    _discountsBloc.close();
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
        buildCategoryHeader(),
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
                return Expanded(
                  child: new ListView.builder(
                    padding:
                        EdgeInsets.all(ScreenUtil.getInstance().setHeight(30)),
                    itemCount: currentState.discount.result.length,
                    itemBuilder: (context, index) {
                      return DiscountItem(
                          context: context,
                          result: currentState.discount.result[index]);
                    },
                  ),
                );
              }
            }),
      ],
    );
  }

  Container buildCategoryHeader() {
    return Container(
        margin: EdgeInsets.only(
          left: ScreenUtil.getInstance().setWidth(40),
        ),
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
      );
  }
}
