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

  @override
  void initState() {
    super.initState();
    // this._load();
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
    // return BlocBuilder<DiscountsBloc, DiscountsState>(
    //     bloc: widget._discountsBloc,
    //     builder: (
    //       BuildContext context,
    //       DiscountsState currentState,
    //     ) {
    //       if (currentState is UnDiscountsState) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       if (currentState is ErrorDiscountsState) {
    //         return Center(
    //             child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: <Widget>[
    //             Text(currentState.errorMessage ?? 'Error'),
    //             Padding(
    //               padding: const EdgeInsets.only(top: 32.0),
    //               child: RaisedButton(
    //                 color: Colors.blue,
    //                 child: Text("reload"),
    //                 onPressed: () => this._load(),
    //               ),
    //             ),
    //           ],
    //         ));
    //       }

    //     });
    return Column(
      children: <Widget>[
        Expanded(
          child: new ListView.builder(
            padding: EdgeInsets.all(ScreenUtil.getInstance().setHeight(30)),
            itemCount: 5,
            itemBuilder: (context, index) {
              // return buildItem(context);
              return buildDiscountItem(context, "Медицинский центр");
            },
          ),
        ),
      ],
    );
  }

  // void _load([bool isError = false]) {
  //   widget._discountsBloc.add(UnDiscountsEvent());
  //   widget._discountsBloc.add(LoadDiscountsEvent(isError));
  // }
  Widget buildItem(BuildContext context) {
    return Container(height: 100, color: Colors.red);
  }

  Widget buildDiscountItem(BuildContext context, String s) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/news_detail');
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
                      child: Text("Медицинский центр", style: Theme.of(context).textTheme.body2,),
                      top: 10,
                      left: 10,
                    ),
                    Positioned(
                      child: Text("Узи органов", style: Theme.of(context).textTheme.display2,),
                      top: 35,
                      left: 10,
                    ),
                    Positioned(
                      child: Text("Пользуются: 99", style: Theme.of(context).textTheme.display2),
                      top: 65,
                      left: 10,
                    ),
                    Positioned(
                      child: Text("от 1 100 тг.", style: Theme.of(context).textTheme.display3),
                      bottom: 30,
                      right: 10,
                    ),
                    Positioned(
                      child: Text("экономия от 2500 тг.", style: Theme.of(context).textTheme.display2),
                      bottom: 10,
                      right: 10,
                    ),
                  ],
                ),
                height: ScreenUtil.getInstance().setHeight(250),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)))),
            decoration: BoxDecoration(
                color: Colors.black38, borderRadius: BorderRadius.circular(10)),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "https://images.homify.com/images/a_0,c_limit,f_auto,h_1024,q_auto,w_1024/v1439301285/p/photo/image/477581/121102_0076/modern-clinics-photos-by-veridiana-negri-arquitetura.jpg")))),
    );
  }
}
