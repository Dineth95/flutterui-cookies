import 'package:flutter/material.dart';

class Cookie {
  final String name;
  final String price;
  final String imgPath;
  final bool added;
  final bool isFavourite;

  Cookie(
      {@required this.name,
      @required this.price,
      @required this.imgPath,
      @required this.added,
      @required this.isFavourite});
}
