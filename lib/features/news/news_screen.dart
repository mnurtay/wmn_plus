import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wmn_plus/features/news/index.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({
    Key key,
    @required NewsBloc newsBloc,
  })  : _newsBloc = newsBloc,
        super(key: key);

  final NewsBloc _newsBloc;

  @override
  NewsScreenState createState() {
    return NewsScreenState(_newsBloc);
  }
}

class NewsScreenState extends State<NewsScreen> {
  final NewsBloc _newsBloc;
  NewsScreenState(this._newsBloc);

  @override
  void initState() {
    super.initState();
    widget._newsBloc.add(UnNewsEvent());
    widget._newsBloc.add(LoadNewsEvent(false));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
        bloc: widget._newsBloc,
        builder: (
          BuildContext context,
          NewsState currentState,
        ) {
          if (currentState is UnNewsState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorNewsState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ?? 'Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text("reload"),
                    onPressed: () {},
                  ),
                ),
              ],
            ));
          }
          if (currentState is InNewsState) {
            return SingleChildScrollView(
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Новости",
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, position) {
                            return buildNewsItem(context);
                          },
                        ),
                      )
                    ],
                  )),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Flutter files: done"),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.red,
                    child: Text("throw error"),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          );
        });
  }

  Container buildNewsItem(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: Container(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Беременность у женщин",
                style: TextStyle(fontSize: 24, color: Colors.white)),
          ),
          decoration: BoxDecoration(
              color: Colors.black38, borderRadius: BorderRadius.circular(16)),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://avatars.mds.yandex.net/get-zen_doc/42056/pub_5bc6ea133887bf00ac5276f4_5bc6ed07f4355200abcac179/scale_1200"))));
  }

  // void _load([bool isError = false]) {

  //   widget._newsBloc.add(LoadNewsEvent(isError));
  // }
}
