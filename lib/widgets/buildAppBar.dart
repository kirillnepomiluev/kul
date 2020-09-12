import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@override
Widget buildAppBar(BuildContext context, String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    flexibleSpace: Container(
      height: 115.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
    ),
    backgroundColor: Colors.blue,
    centerTitle: false,
    elevation: 0,
  );
}
