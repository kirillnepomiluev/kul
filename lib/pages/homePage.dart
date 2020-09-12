import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kul/widgets/MyScaffold.dart';
import 'package:kul/widgets/myCard.dart';

import '../topTabBarSilver.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return buildMyScaffold(
        context, MainCollapsingToolbar(expandleHeight: 400,titleMain: "Узнай свои льготы",
      body:
      Container(),imageHeader: Image.asset("assets/homeAppBar.jpg",
        fit: BoxFit.fitWidth, alignment: Alignment.bottomCenter)
      ,), "Главная",isAppbar: false);
  }

  Widget buildMyHome (BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //          Пагинация
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white,
                      width: 1,
                      style: BorderStyle.solid),
                  color: Colors.black,
                ),
                child: FlatButton(
                  child: Text(
                    'Домашняя',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "OpenSansReg",
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal),
                  ),
                  onPressed: () {
//                          Navigator.pushNamed(context, '/scancartrige');
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                    Color(0xFF007AFF),
                    Color(0xFF1ED761)
                  ]),
//                        border: Border.all(width: 1, style: BorderStyle.solid,color: Color(0xFFF2F2F2)),
                ),
                child: FlatButton(
                  child: Text('Заполнить анкету',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "OpenSansReg",
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal)),
                  onPressed: () {
//                          Navigator.pushNamed(
//                              context, '/ScanCartrigeInfoPacient');
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                      color: Color(0xFFF2F2F2),
                      width: 1,
                      style: BorderStyle.solid),
                ),
                child: FlatButton(
                  child: Text('Категории льгот',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "OpenSansReg",
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal)),
                  onPressed: () {
//                          Navigator.pushNamed(context, '/DataVerification');
                  },
                ),
              ),
            ]),)
          ],),
          Row(
            children: [
              Column(children: [
                myCard(context,child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Text('Уважаемые пользователи! У Вас есть возможность узнать о'
                      'положенных Вам льготах, либо проверить себя в базе  данных Самарской области по отдельным льготным категориям. '
                      'Для проверки учёта, введите свои данные и нажмите кнопку «Проверить»',style: TextStyle(fontSize: 30),),
                ))
              ],),
            ],
          ),
        ],
      ),
    );
  }

}