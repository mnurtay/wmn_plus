import 'package:flutter/material.dart';
import 'package:wmn_plus/features/shop/shop_model.dart';

class CatergoryItem extends StatelessWidget {
  const CatergoryItem({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Products product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 130,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(product.title,
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
