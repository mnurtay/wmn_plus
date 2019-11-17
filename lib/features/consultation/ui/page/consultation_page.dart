import 'package:flutter/material.dart';
import 'package:wmn_plus/features/consultation/ui/widget/consultation_data.dart';

class ConsultationPage extends StatefulWidget {
  @override
  _ConsultationPageState createState() => _ConsultationPageState();
}

class _ConsultationPageState extends State<ConsultationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDCDCDC).withOpacity(0.4),
      body: ConsultationData(),
    );
  }
}
