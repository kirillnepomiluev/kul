import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget myCard ( BuildContext context ,{Widget child}) {
  return  Card(
    elevation: 5,
    shadowColor: Colors.blueGrey,
    borderOnForeground: true,
    color: Colors.white,
    shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
//  margin: new EdgeInsets.all(15),
    child :child ,
  );
}
