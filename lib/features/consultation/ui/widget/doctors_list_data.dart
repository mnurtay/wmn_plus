import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorsListData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: ScreenUtil().setHeight(50)),
        doctorCard(context),
        doctorCard(context),
      ],
    );
  }

  Widget doctorCard(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.all(Radius.circular(ScreenUtil().setSp(30))),
        ),
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(30),
            horizontal: ScreenUtil().setWidth(30)),
        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- DOCTOR IMAGE
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(ScreenUtil().setSp(40))),
                  color: Color(0xFFF5F5F5),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://www.aamc.org/sites/default/files/risking-everything-to-become-a-doctor-jirayut-new-latthivongskorn.jpg'),
                      fit: BoxFit.cover)),
            ),
            SizedBox(width: ScreenUtil().setWidth(25)),
            // --- DOCTOR INFORMATION
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Text(
                      'Dr. Gary Hawkins',
                      style: Theme.of(context).textTheme.body2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: ScreenUtil().setHeight(20)),
                    Text(
                      'Sr. Psychology',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.display2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
