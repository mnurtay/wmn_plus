import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/features/profile/change_mode/index.dart';

class ChangeModeScreen extends StatefulWidget {
  const ChangeModeScreen({
    Key key,
    @required ChangeModeBloc changeModeBloc,
  })  : _changeModeBloc = changeModeBloc,
        super(key: key);

  final ChangeModeBloc _changeModeBloc;

  @override
  ChangeModeScreenState createState() {
    return ChangeModeScreenState(_changeModeBloc);
  }
}

class ChangeModeScreenState extends State<ChangeModeScreen> {
  final ChangeModeBloc _changeModeBloc;
  ChangeModeScreenState(this._changeModeBloc);

  @override
  void initState() {
    super.initState();
    this._load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeModeBloc, ChangeModeState>(
        bloc: widget._changeModeBloc,
        builder: (
          BuildContext context,
          ChangeModeState currentState,
        ) {
          if (currentState is UnChangeModeState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorChangeModeState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ?? 'Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('reload'),
                    onPressed: () => this._load(),
                  ),
                ),
              ],
            ));
          }
          return Column(
            children: <Widget>[
              Expanded(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 25,
                      ),
                      buildMainColumn(context)
                    ],
                  )),
                ),
              )),
            ],
          );
        });
  }

  Column buildMainColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // buildWelcomeRow(),
        Text(
          "Измените свою группу",
          style: TextStyle(
            fontSize: ScreenUtil().setSp(55),
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        buildModeItem(context, "Фертильность", "", 1),
        buildModeItem(context, "Беременность", "",2),
        buildModeItem(context, "Климакс", "",3)
      ],
    );
  }


  Widget buildModeItem(BuildContext context, String mode, String url, int version) {
    return InkWell(
      onTap: () {
        if (version == 1)
          Navigator.pushNamed(context, '/change_mode_fertility');
        else if (version == 2) 
          Navigator.pushNamed(context, '/change_mode_pregnancy');
        else 
          Navigator.pushNamed(context, '/change_mode_fertility');
      },
      child: Container(
          margin:
              EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(25)),
          height: ScreenUtil.getInstance().setHeight(400),
          width: MediaQuery.of(context).size.width,
          child: Container(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(ScreenUtil.getInstance().setHeight(50)),
              child: Text(mode,
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(50),
                      color: Colors.white)),
            ),
            decoration: BoxDecoration(
                color: Colors.black38, borderRadius: BorderRadius.circular(10)),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(url)))),
    );
  }

  void _load([bool isError = false]) {
    widget._changeModeBloc.add(UnChangeModeEvent());
    widget._changeModeBloc.add(LoadChangeModeEvent(isError));
  }
}
