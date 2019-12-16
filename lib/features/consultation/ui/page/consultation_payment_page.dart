import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ConsulatationPaymentPage extends StatefulWidget {
  final String url;

  const ConsulatationPaymentPage({Key key, @required this.url})
      : super(key: key);
  @override
  _ConsulatationPaymentPageState createState() =>
      _ConsulatationPaymentPageState();
}

class _ConsulatationPaymentPageState extends State<ConsulatationPaymentPage> {
  int _stackToView = 1;

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
          size: ScreenUtil().setSp(75),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.close),
        ),
      ),
      body: IndexedStack(
        index: _stackToView,
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: WebView(
                  initialUrl: widget.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: _handleLoad,
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
