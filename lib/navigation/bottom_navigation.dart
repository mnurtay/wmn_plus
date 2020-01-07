import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wmn_plus/util/config.dart';

class BottomNavigation extends StatefulWidget {
  final List pageOptions;
  final List<Widget> barItems;
  final int selectedPage;
  final Color modeColor;

  BottomNavigation(
      {@required this.modeColor,
      @required this.pageOptions,
      @required this.barItems,
      this.selectedPage = 0});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedPage;

  @override
  void initState() {
    selectedPage = widget.selectedPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(
        width: DEVICE_WIDTH, height: DEVICE_HEIGHT, allowFontScaling: true)
      ..init(context);
    return Scaffold(
      body: widget.pageOptions[selectedPage],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: widget.modeColor,
        index: selectedPage,
        animationCurve: Curves.easeInOutCirc,
        // backgroundColor: Theme.of(context).primaryColor,
        height: 65,
        items: widget.barItems,
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
    );
  }
}
