import 'package:flutter/material.dart';
import 'package:wmn_plus/features/ecommerce/utils/constants.dart';
import 'package:wmn_plus/features/ecommerce/screens/update_address.dart';

final processSnackbar = SnackBar(
  content: Text('Добавление товара в корзину...'),
  duration: Duration(seconds: 1),
);
final processWhatsAppSnackbar = SnackBar(
  content: Text('Отправка товара в WhatsApp...'),
  duration: Duration(seconds: 1),
);
final completeSnackbar = SnackBar(
  content: Text('Товар успешно добавлен в корзину!'),
  duration: Duration(seconds: 1),
);
final codAvailable = SnackBar(
  content: Text('Cash on Delivery is available!'),
  duration: Duration(seconds: 1),
);
final codNotAvailable = SnackBar(
  content: Text('Cash on Delivery is not available!'),
  duration: Duration(seconds: 1),
);

final insufficientAmt = SnackBar(
  content: Text(
      'Order should be greater than $CURRENCY_SYMBOL ${FREE_SHIPPING_AMOUNT.toString()} for COD'),
  duration: Duration(seconds: 3),
);
final codEmpty = SnackBar(
  content: Text('Please enter a Pincode!'),
  duration: Duration(seconds: 1),
);
final promoEmpty = SnackBar(
  content: Text('Please enter a Promo Code!'),
  duration: Duration(seconds: 1),
);
final ErrorSnackbar = SnackBar(
  content: Text('Please Enter title and review'),
  duration: Duration(seconds: 1),
);
final LoginErroSnackbar = SnackBar(
  content: Text('Please Login to write review.'),
  duration: Duration(seconds: 1),
);
