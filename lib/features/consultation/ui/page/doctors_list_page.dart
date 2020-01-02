import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/consultation/bloc/bloc.dart';
import 'package:wmn_plus/features/consultation/ui/widget/doctors_list_data.dart';
import 'package:wmn_plus/features/consultation/model/Doctor.dart';

class DoctorsListPage extends StatefulWidget {
  final Map category;
  DoctorsListPage({@required this.category});
  @override
  _DoctorsListPageState createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  ConsultationBloc consultationBloc;

  @override
  void initState() {
    consultationBloc = ConsultationBloc();
    consultationBloc
        .add(FetchDoctorsListEvent(categoryId: widget.category['id']));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        title: Text(widget.category['value']),
        textTheme: Theme.of(context).textTheme,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
      ),
      body: blocListener(context),
    );
  }

  Widget blocListener(BuildContext context) {
    return BlocBuilder(
      bloc: consultationBloc,
      builder: (context, state) {
        if (state is FetchedDoctorsListState) {
          return buildContent(context, state.doctors);
        }
        if (state is LoadingConsultationState) {
          return Center(child: CircularProgressIndicator());
        }
        return Container();
      },
    );
  }

  Widget buildContent(BuildContext context, List<Doctor> doctors) {
    TextStyle textStyle = TextStyle(
        fontSize: ScreenUtil().setSp(50),
        fontWeight: FontWeight.w200,
        letterSpacing: 0.2);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(50),
            vertical: ScreenUtil().setHeight(50)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Найди своего', style: textStyle),
            Text(
              'Консультанта',
              style: textStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtil().setSp(75)),
            ),
            DoctorsListData(doctors: doctors),
          ],
        ),
      ),
    );
  }
}
