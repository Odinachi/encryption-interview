import 'package:flutter/material.dart';

double screenWidth(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.width;
}

double screenHeight(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height;
}
