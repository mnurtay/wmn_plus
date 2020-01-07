import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/news/news_state.dart';
import 'package:wmn_plus/features/news/widgets/news_item.dart';

class NewsList extends StatelessWidget {
  NewsList({
    @required this.currentState,
    Key key,
  }) : super(key: key);
  final InNewsState currentState;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: new ListView.builder(
        padding: EdgeInsets.all(ScreenUtil.getInstance().setHeight(30)),
        itemCount: currentState.newsList.length,
        itemBuilder: (context, index) {
          return NewsItem(context: context, data: currentState.newsList[index]);
        },
      ),
    );
  }
}
