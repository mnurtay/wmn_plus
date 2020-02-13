import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/consultation/model/Consultation.dart';
import 'package:wmn_plus/features/consultation/ui/widget/chat_data.dart';
import 'dart:convert';
import 'package:wmn_plus/features/consultation/model/Doctor.dart';

class ChatPage extends StatefulWidget {
  final Consultation consultation;
  final Result currentUser;
  final String role;
  final String fullName;
  ChatPage(
      {@required this.consultation,
      @required this.currentUser,
      @required this.fullName,
      this.role = "pat"});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  bool textFieldIsEmpty = true;
  Doctor doctor;
  Result user;
  File _image;

  IOWebSocketChannel channel;

  @override
  void initState() {
    if (widget.role == "doctor") {
      doctor = widget.consultation.doctor;
      String url =
          'ws://194.146.43.98:8080/conversation?token=${widget.currentUser.token}&convID=${widget.consultation.id}&role=DOC';
      channel = IOWebSocketChannel.connect(url);
    } else {
      doctor = widget.consultation.doctor;
      print(widget.currentUser.token + "!!!!!!!" + widget.consultation.id);
      String url =
          'ws://194.146.43.98:8080/conversation?token=${widget.currentUser.token}&convID=${widget.consultation.id}&role=PAT';
      channel = IOWebSocketChannel.connect(url);
    }

    super.initState();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        compressQuality: 50,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Отправить фото',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(

          minimumAspectRatio: 1.0,
        ));

    var byte = await _readFileByte(croppedFile.path);
  
    _sendMessageImage(byte);

    setState(() {
      if (widget.role == "doctor") {
        doctor = widget.consultation.doctor;
        String url =
            'ws://194.146.43.98:8080/conversation?token=${widget.currentUser.token}&convID=${widget.consultation.id}&role=DOC';
        channel = IOWebSocketChannel.connect(url);
      } else {
        doctor = widget.consultation.doctor;
        print(widget.currentUser.token + "!!!!!!!" + widget.consultation.id);
        String url =
            'ws://194.146.43.98:8080/conversation?token=${widget.currentUser.token}&convID=${widget.consultation.id}&role=PAT';
        channel = IOWebSocketChannel.connect(url);
      }
    });
  }

  Future<Uint8List> _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File picFile = new File.fromUri(myUri);
    Uint8List bytes;
    await picFile.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
      print('reading of bytes is completed');
    }).catchError((onError) {
      print(
          'Exception Error while reading pic from path:' + onError.toString());
    });
    return bytes;
  }

  void _sendMessageImage(Uint8List bytes) {
    if (widget.role == "doctor") {
      FocusScope.of(context).requestFocus(FocusNode());
      Map object = {
        'status': 'SEND_IMAGE',
        'from': 'DOC',
        'content': base64Encode(bytes)
      };
      channel.sink.add(json.encode(object));
      messageController.clear();
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
      Map object = {
        'status': 'SEND_IMAGE',
        'from': 'PAT',
        'content': bytes.toString()
      };
      channel.sink.add(json.encode(object));
      messageController.clear();
    }

    setState(() {
      textFieldIsEmpty = true;
    });
  }

  void _sendMessage() {
    if (widget.role == "doctor") {
      FocusScope.of(context).requestFocus(FocusNode());
      if (messageController.text.isNotEmpty) {
        Map object = {
          'status': 'SEND_MESSAGE',
          'from': 'DOC',
          'content': messageController.text
        };
        channel.sink.add(json.encode(object));
        messageController.clear();
      }
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
      if (messageController.text.isNotEmpty) {
        Map object = {
          'status': 'SEND_MESSAGE',
          'from': 'PAT',
          'content': messageController.text
        };
        channel.sink.add(json.encode(object));
        messageController.clear();
      }
    }

    setState(() {
      textFieldIsEmpty = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ChatData(channel: channel, type: widget.role),
          ),
          bottomBar(context, channel),
        ],
      ),
    );
  }

  Widget bottomBar(BuildContext context, WebSocketChannel channel) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(20),
          bottom: ScreenUtil().setHeight(60),
          left: ScreenUtil().setWidth(35),
          right: ScreenUtil().setWidth(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              child: Icon(Icons.attach_file),
              onTap: getImage,
            ),
          ),
          // --- TEXT FIELD
          Expanded(
            child: TextField(
              controller: messageController,
              style: TextStyle(
                  fontFamily: 'HolyFat',
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(ScreenUtil().setSp(70)))),
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(60),
                    vertical: ScreenUtil().setHeight(20)),
                hintText: 'Написать...',
              ),
              onEditingComplete: _sendMessage,
              autocorrect: false,
              // onChanged: (value) {
              //   setState(() {
              //     textFieldIsEmpty = value.isEmpty;
              //   });
              // },
            ),
          ),
          // --- SEND ICON
          RotationTransition(
            turns: AlwaysStoppedAnimation((textFieldIsEmpty ? 0 : 0) / 360),
            child: IconButton(
              icon: Icon(
                Icons.send,
                color: textFieldIsEmpty ? Colors.grey : Color(0xFF7B68EE),
                size: ScreenUtil().setSp(70),
              ),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar(BuildContext context) {
    if (widget.role == "doctor") {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        iconTheme: IconThemeData(color: Colors.black),
        title: GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, "/doctor_page", arguments: doctor),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                  backgroundColor: Color(0xFFF5F5F5),
                  backgroundImage: NetworkImage(doctor.image),
                  child: Container()),
              SizedBox(width: ScreenUtil().setWidth(30)),
              Text(
                "${widget.fullName}",
                style: Theme.of(context).textTheme.body1,
              ),
            ],
          ),
        ),
      );
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        iconTheme: IconThemeData(color: Colors.black),
        title: GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, "/doctor_page", arguments: doctor),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                  backgroundColor: Color(0xFFF5F5F5),
                  backgroundImage: NetworkImage(doctor.image),
                  child: Container()),
              SizedBox(width: ScreenUtil().setWidth(30)),
              Text(
                "${widget.fullName}",
                style: Theme.of(context).textTheme.body1,
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    channel.sink.close();
    super.dispose();
  }
}
