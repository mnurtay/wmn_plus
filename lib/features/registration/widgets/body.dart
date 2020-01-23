import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyRegistration extends StatefulWidget {
  BodyRegistration({
    Key key,
    @required TextEditingController controllerName,
    @required TextEditingController controllerSur,
    @required TextEditingController controllerEmail,
    @required TextEditingController controllerPass,
    @required TextEditingController controllerPasswordVerification,
    @required String birth,
  })  : _controllerName = controllerName,
        _controllerSur = controllerSur,
        _birth = birth,
        _controllerEmail = controllerEmail,
        _controllerPass = controllerPass,
        _controllerPasswordVerification = controllerPasswordVerification,
        super(key: key);

  String _birth;
  final TextEditingController _controllerName;
  final TextEditingController _controllerSur;
  final TextEditingController _controllerEmail;
  final TextEditingController _controllerPass;
  final TextEditingController _controllerPasswordVerification;
  @override
  _BodyRegistrationState createState() => _BodyRegistrationState();
}

class _BodyRegistrationState extends State<BodyRegistration> {
  @override
  Widget build(BuildContext context) {
    
  }
}
