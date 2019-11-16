import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final List pageOptions;
  final List<BottomNavigationBarItem> barItems;
  final int selectedPage;

  BottomNavigation(
      {@required this.pageOptions,
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
    return Scaffold(
      body: widget.pageOptions[selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPage,
        onTap: (int index) {
          setState(() {
            selectedPage = index;
          });
        },
        fixedColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: widget.barItems,
      ),
    );
  }
}
