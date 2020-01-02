import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: WebView(
                initialUrl: "https://www.wmnplus.com",
                javascriptMode: JavascriptMode.unrestricted,
                // onPageFinished: _handleLoad,
              ),
            ),
          ],
        ));
  }
}
