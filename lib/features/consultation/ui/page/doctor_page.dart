import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/consultation/bloc/bloc.dart';
import 'package:wmn_plus/features/consultation/model/Consultation.dart';
import 'package:wmn_plus/features/consultation/model/Doctor.dart';
import 'package:wmn_plus/features/consultation/ui/widget/doctor_data.dart';

class DoctorPage extends StatefulWidget {
  final Doctor doctor;
  DoctorPage({@required this.doctor});
  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  ConsultationBloc consultationBloc;

  @override
  void initState() {
    consultationBloc = ConsultationBloc();
    super.initState();
  }

  void onPressConsultationButton() {
    consultationBloc.add(ConsultationPaymentEvent(doctorId: widget.doctor.id));
    _showModal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Colors.white,
      body: DoctorData(
        doctor: widget.doctor,
        onPressButton: this.onPressConsultationButton,
      ),
      bottomNavigationBar: button(context),
    );
  }

  Widget button(BuildContext context) {
    return Container(
      height: 60,
      width: ScreenUtil().width,
      child: RaisedButton(
        onPressed: () => onPressConsultationButton(),
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
        color: Colors.purpleAccent,
        child: Text('Консультироваться',
            style: TextStyle(
                fontFamily: 'HolyFat',
                fontWeight: FontWeight.w500,
                fontSize: ScreenUtil.getInstance().setSp(50),
                color: Colors.white)),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    );
  }

  Widget blocBuilder(BuildContext context) {
    return BlocBuilder(
      bloc: consultationBloc,
      builder: (context, state) {
        // -- loding state
        if (state is LoadingConsultationState) {
          return modalBody(context: context, child: loadingContent(context));
        }
        if (state is FetchedConsultationPaymentState) {
          if (state.payment["message"] != "EXIST") {
            return modalBody(
                context: context,
                child: paymentContent(context, state.payment));
          }
          return modalBody(
              context: context,
              child: existPaymentContent(context, state.payment));
        }
        // -- error state
        return modalBody(context: context, child: errorContent(context));
      },
    );
  }

  Widget existPaymentContent(BuildContext context, Map objectMap) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          SizedBox(height: ScreenUtil().setHeight(30)),
          Container(
            width: ScreenUtil().width,
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(60),
            ),
            child: RaisedButton(
              onPressed: () {
                final consultation =
                    Consultation.parseObject(objectMap['result']);
                final user = Result.fromJson(objectMap['result']['patient']);
                Navigator.pushNamed(context, '/chat_page', arguments: {
                  "consultation": consultation,
                  'user': user,
                  'type': "pat",
                  'full_name': widget.doctor.getFullName,
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(ScreenUtil().setSp(25)),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(35),
              ),
              child: Text(
                "Написать сообщение",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil.getInstance().setSp(50),
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget paymentContent(BuildContext context, Map payment) {
    print(widget.doctor);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25)),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Text(
            'Оплатите ${widget.doctor.price}₸ доктору чтобы продолжить.',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: ScreenUtil.getInstance().setSp(50),
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: ScreenUtil().setHeight(30)),
          Container(
            width: ScreenUtil().width,
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(60),
            ),
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  '/consultation_payment',
                  arguments: payment['result'],
                ).whenComplete(() {
                  consultationBloc.add(
                      ConsultationPaymentEvent(doctorId: widget.doctor.id));
                  _showModal();
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(ScreenUtil().setSp(25)),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(35),
              ),
              child: Text(
                "Оплатить",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil.getInstance().setSp(50),
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget loadingContent(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
      ),
    );
  }

  Widget errorContent(BuildContext context) {
    return Center(
      child: Text(
        'Ошибка загрузки данных.\nПовторите попытку позже',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: ScreenUtil.getInstance().setSp(50),
          color: Colors.grey,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget modalBody({@required BuildContext context, @required Widget child}) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(20),
          horizontal: ScreenUtil().setWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.close,
              color: Colors.grey,
              size: ScreenUtil().setSp(80),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          SizedBox(height: ScreenUtil().setHeight(20)),
          child,
        ],
      ),
    );
  }

  _showModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          color: Color(0XFF737373),
          alignment: Alignment.center,
          height: ScreenUtil().setHeight(600),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ScreenUtil().setWidth(45)),
                topRight: Radius.circular(ScreenUtil().setWidth(45)),
              ),
            ),
            child: blocBuilder(context),
          ),
        );
      },
    );
  }
}
