import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_socket_channel/io.dart';
import 'package:wmn_plus/features/auth/bloc/bloc.dart';
import 'package:wmn_plus/features/auth/model/User.dart';
import 'package:wmn_plus/features/consultation/bloc/bloc.dart';
import 'package:wmn_plus/features/consultation/model/Consultation.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  AuthBloc authBloc;
  ConsultationBloc consultationBloc;
  List<Consultation> consultations = [];
  TextEditingController searchController = TextEditingController();
  String oldData = '';
  User currentUser;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    consultationBloc = ConsultationBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: authBloc,
      builder: (context, state) {
        String url = 'ws://194.146.43.98:8080/convlist?role=PAT&token=';
        if (state is AuthenticatedFertilityModeState) {
          url += state.user.result.token;
          currentUser = state.user;
        } else if (state is AuthenticatedPregnantModeState) {
          url += state.user.result.token;
          currentUser = state.user;
        } else if (state is AuthenticatedClimaxModeState) {
          url += state.user.result.token;
          currentUser = state.user;
        } else if (state is AuthenticatedDoctorAuthState) {
          // url = 'ws://194.146.43.98:8080/convlist?role=DOC&token=';
          // url += state.user.result.token;
        }
        IOWebSocketChannel channel = IOWebSocketChannel.connect(url);
        return Scaffold(
          backgroundColor: Color(0xFFF5F5F5),
          appBar: appBarDefault(context),
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.white,
                  Colors.white,
                  Theme.of(context).accentColor
                ])),
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: ScreenUtil().setHeight(50)),
                searchWidget(context),
                SizedBox(height: ScreenUtil().setHeight(50)),
                chatList(context, channel),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget appBarDefault(BuildContext context) {
    return AppBar(
      title: Text(
        "Консультация",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      centerTitle: false,
      elevation: 4,
      actions: <Widget>[
        Container(
          padding: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/new_consultation'),
            child: Icon(
              Icons.add,
              size: ScreenUtil().setSp(80),
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget chatList(BuildContext context, IOWebSocketChannel channel) {
    return StreamBuilder(
      stream: channel.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != oldData) {
          oldData = snapshot.data;
          consultationBloc
              .add(ConsultationConfig(consultationList: snapshot.data));
        }
        return blocListener(context);
      },
    );
  }

  Widget blocListener(BuildContext context) {
    return BlocListener(
      bloc: consultationBloc,
      listener: (context, state) {
        if (state is FetchedConsultationState) {
          setState(() {
            consultations = state.consultations;
          });
        }
      },
      child: chatListBody(context),
    );
  }

  Widget chatListBody(BuildContext context) {
    if (consultations.isEmpty) {
      return Column(
        children: <Widget>[
          SizedBox(height: ScreenUtil().setHeight(50)),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(30),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(ScreenUtil().setSp(30)),
              ),
            ),
            child: Text(
              'Вы можете начать консультации, нажав кнопку +',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }
    return Column(
      children: consultations.map((item) {
        String search = searchController.text.toLowerCase();
        String name = item.doctor.firstName.toLowerCase();
        String surname = item.doctor.surname.toLowerCase();
        if (search.isEmpty ||
            search == name.substring(0, search.length) ||
            search == surname.substring(0, search.length)) {
          return chatItem(context, item);
        }
        return Container();
      }).toList(),
    );
  }

  Widget chatItem(BuildContext context, Consultation consultation) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/chat_page',
        arguments: {"consultation": consultation, 'user': currentUser},
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.all(Radius.circular(ScreenUtil().setSp(30))),
        ),
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setHeight(30),
            horizontal: ScreenUtil().setWidth(30)),
        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- DOCTOR IMAGE
            doctorAvatar(context, consultation),
            // --- CHAT INFORMATION
            SizedBox(width: ScreenUtil().setWidth(35)),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "${consultation.doctor.surname} ${consultation.doctor.firstName}",
                            style: Theme.of(context).textTheme.body2,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        consultation.newMessageCount != 0
                            ? Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.red),
                                child: Center(
                                  child: Text('${consultation.newMessageCount}',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              )
                            : Text('${consultation.date}',
                                style: Theme.of(context).textTheme.display2),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Text(
                      consultation.messageFromMe
                          ? "Вы: ${consultation.messageContent}"
                          : consultation.messageContent,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.display2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget doctorAvatar(BuildContext context, Consultation consultation) {
    if (consultation.doctor.image == '') {
      return Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              ScreenUtil().setSp(40),
            ),
          ),
          color: Color(0xFFF5F5F5),
        ),
        child: Center(
          child: Icon(
            Icons.person,
            size: ScreenUtil().setSp(100),
            color: Colors.grey,
          ),
        ),
      );
    }
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(ScreenUtil().setSp(40))),
          color: Color(0xFFF5F5F5),
          image: DecorationImage(
              image: NetworkImage(consultation.doctor.image),
              fit: BoxFit.cover)),
    );
  }

  Widget searchWidget(BuildContext context) {
    InputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(60))),
      borderSide: BorderSide(color: Colors.grey),
    );
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        border: inputBorder,
        focusedBorder: inputBorder,
        contentPadding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(30),
          horizontal: ScreenUtil().setWidth(30),
        ),
        prefixIcon: Icon(Icons.search, color: Colors.black),
        filled: true,
        fillColor: Color(0xFFF5F5F5),
        hintText: 'Поиск',
      ),
      onChanged: (value) {
        setState(() {});
      },
      autocorrect: false,
      style: Theme.of(context).textTheme.body1,
    );
  }

  Widget appBar(BuildContext context) {
    return AppBar(
      title: Text('Консультация', style: Theme.of(context).textTheme.title),
      backgroundColor: Colors.white,
      centerTitle: false,
      elevation: 0,
      actions: <Widget>[
        Container(
          padding: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/new_consultation'),
            child: Icon(
              Icons.add,
              size: ScreenUtil().setSp(80),
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
