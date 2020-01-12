import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/news/news_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({
    Key key,
    @required this.context,
    @required this.data,
  }) : super(key: key);

  final BuildContext context;
  final NewsModel data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/news_detail',
            arguments: data.id.toString());
      },
      child: Container(
          margin:
              EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(25)),
          height: ScreenUtil.getInstance().setHeight(500),
          width: MediaQuery.of(context).size.width,
          child: Container(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(ScreenUtil.getInstance().setHeight(50)),
              child: Text(data.name,
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(50),
                      color: Colors.white)),
            ),
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(10)),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(data.imageUrl)))),
    );
  }
}
