import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/consultation/model/Doctor.dart';

class DoctorData extends StatefulWidget {
  final Doctor doctor;
  final Function onPressButton;
  DoctorData({@required this.doctor, @required this.onPressButton});
  @override
  _DoctorDataState createState() => _DoctorDataState();
}

class _DoctorDataState extends State<DoctorData> {
  @override
  Widget build(BuildContext context) {
    var _deviceSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            header(context, _deviceSize),
            SizedBox(height: ScreenUtil().setHeight(30)),
            body(context),
            SizedBox(height: ScreenUtil().setHeight(50)),
            // button(context),
          ],
        ),
      ),
    );
  }

  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${widget.doctor.getFullName}",
            style: TextStyle(
                fontFamily: 'HolyFat',
                fontSize: 34,
                fontWeight: FontWeight.w200),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(10),
                  color: Colors.orangeAccent.withOpacity(0.3),
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                child: Text(
                  getSpeciality(),
                  style: TextStyle(
                      color: Colors.orange,
                      fontFamily: 'HolyFat',
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.doctor.speciality,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'HolyFat',
                    fontSize: 18,
                    fontWeight: FontWeight.w200),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: new BorderRadius.circular(14),
              //     color: Colors.blueAccent.withOpacity(0.6),
              //   ),
              //   padding: EdgeInsets.all(16),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: <Widget>[
              //       Text(
              //         "Консультировано:",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontFamily: 'HolyFat',
              //             fontSize: 13,
              //             fontWeight: FontWeight.w400),
              //       ),
              //       Text(
              //         "980",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontFamily: 'HolyFat',
              //             fontSize: 16,
              //             fontWeight: FontWeight.w600),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(14),
                  color: Colors.orangeAccent.withOpacity(0.6),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Опыт работы",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'HolyFat',
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${widget.doctor.experience} год",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'HolyFat',
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(14),
                  color: Colors.redAccent.withOpacity(0.6),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Cтепень образования:",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'HolyFat',
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "${widget.doctor.study}",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'HolyFat',
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  header(BuildContext context, Size _deviceSize) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
        ),
        Expanded(
            child: Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.only(
              bottomLeft: const Radius.circular(40.0),
            ),
            color: Colors.purpleAccent,
          ),
          child: Container(
              alignment: Alignment.bottomRight,
              child: ClipRRect(
                child: Image.network(
                    "http://194.146.43.98:4000/image?uri=/home/golang/src/wmn/icons/5.png"),
                borderRadius: BorderRadius.circular(12),
              )),
        ))
      ],
    );
  }

  String getSpeciality() {
    switch (widget.doctor.positionId) {
      case 0:
        return "Акушер-гинеколог";
      case 1:
        return "Эндокринолог";
      case 2:
        return "Психолог";
      case 3:
        return "Педиатр";
      case 4:
        return "Аллерголог";
    }
  }
}
