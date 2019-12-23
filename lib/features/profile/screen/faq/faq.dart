import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FAQ extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FAQ();
  }
}

class Question {
  Question(
      {@required this.title, @required this.answer, this.isExpanded = false});

  final String title;
  final String answer;
  bool isExpanded;
}

class _FAQ extends State<FAQ> {
  @override
  void initState() {
    super.initState();
  }
  List<Question> questionList = <Question>[
      Question(title: "!", answer: "words.answer1"),
      Question(title: "words.question2", answer: "words.answer2"),
      Question(title: "words.question3", answer: "words.answer3"),
      Question(title: "words.question4", answer: "words.answer4"),
      Question(title: "words.question5", answer: "words.answer5"),

    ];
  @override
  Widget build(BuildContext context) {
 
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'FAQ',
                style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(60)),
              ),
              backgroundColor: Theme.of(context).backgroundColor,
            ),
            body: SingleChildScrollView(
              padding:
                  EdgeInsets.only(bottom: ScreenUtil.getInstance().setSp(70)),
              child: Container(
                child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      questionList[index].isExpanded = !questionList[index].isExpanded;
                    });
                  },
                  children: questionList.map((item) {
                    return ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(
                            item.title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(45),
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                        );
                      },
                      canTapOnHeader: true,
                      isExpanded: item.isExpanded,
                      body: Container(
                        margin: EdgeInsets.only(
                          left: ScreenUtil.getInstance().setSp(30),
                          right: ScreenUtil.getInstance().setSp(30),
                          bottom: ScreenUtil.getInstance().setSp(30),
                        ),
                        child: Text(
                          item.answer,
                          style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(40),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        
  }
}