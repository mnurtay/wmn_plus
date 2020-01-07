import 'package:flutter/material.dart';

class RecommendedProduct extends StatelessWidget {
  const RecommendedProduct({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Подушка",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                Text("Подходит вам сейчас",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300)),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    Text("Подробней",
                        style: TextStyle(
                            color: Color(0xff0CB19A4),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300)),
                    Icon(
                      Icons.arrow_forward,
                      color: Color(0xff0CB19A4),
                      size: 16.0,
                    )
                  ],
                )
              ],
            )),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(16),
              ),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
