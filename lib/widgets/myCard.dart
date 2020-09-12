import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget myCard ( BuildContext context ,{Widget child, Color color, double radius,double elevation, Color shadowColor }) {
  return  Card(
    elevation: elevation,
    shadowColor: shadowColor,
    borderOnForeground: true,
    color: color,
    shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
//  margin: new EdgeInsets.all(15),
    child :child ,
  );
}

Widget myPaginacia (BuildContext context){
  return Container(
    width: MediaQuery.of(context).size.width*1,
    height: MediaQuery.of(context).size.height*0.1,
    child:
    Row(children: [
      Expanded(
        child: Container(
          child: myCard(context,radius: 0,elevation: 15,shadowColor: Colors.black,
            child: Container(
              height: MediaQuery.of(context).size.height*0.1,
              decoration: BoxDecoration(
//                border: Border.all(
//                    color: Colors.white,
//                    width: 1,
//                    style: BorderStyle.solid),
                color: Colors.red,
              ),
              child: FlatButton(
                child: Text(
                  'Домашняя',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "OpenSansReg",
                      fontSize: 26,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
//                          Navigator.pushNamed(context, '/scancartrige');
                },
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          child: myCard(context,radius: 0,elevation: 15,shadowColor: Colors.black,
            child: Container(
              height: MediaQuery.of(context).size.height*0.1,
              decoration: BoxDecoration(
                color: Colors.white30,
//                border: Border.all(width: 1, style: BorderStyle.solid,color: Color(0xFFF2F2F2)),
              ),
              child: FlatButton(
                child: Text('Заполнить анкету',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "OpenSansReg",
                        fontSize: 26,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
//                          Navigator.pushNamed(
//                              context, '/ScanCartrigeInfoPacient');
                },
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          child: myCard(context,radius: 0,elevation: 15,shadowColor: Colors.black,
            child: Container(
              height: MediaQuery.of(context).size.height*0.1,
              decoration: BoxDecoration(
                color: Colors.blue,
//                border: Border.all(
////                    color: Color(0xFFF2F2F2),
//                    width: 1,
//                    style: BorderStyle.solid),
              ),
              child: FlatButton(
                child: Text('Категории льгот',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "OpenSansReg",
                        fontSize: 26,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold)),
                onPressed: () {
                          Navigator.pushNamed(context, '/categoriesPage');
                },
              ),
            ),
          ),
        ),
      ),
    ]),
  );
}
