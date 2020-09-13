import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kul/widgets/MyScaffold.dart';
import 'package:kul/widgets/myCard.dart';

import '../topTabBarSilver.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return buildMyScaffold(
        context,
        MainCollapsingToolbar(
          expandleHeight: 400,
          titleMain: "Узнай свои льготы",
          body: buildMyHome(context),
          imageHeader: Image.asset("assets/homeAppBar.jpg",
              fit: BoxFit.fitWidth, alignment: Alignment.bottomCenter),
        ),
        "Главная",
        isAppbar: false);
  }

  Widget buildMyHome(BuildContext context) {
    return Scaffold(
//      backgroundColor: Color(0xFF9FA09A),
      body: Column(
        children: [
          Row(
            children: [Expanded(child: myPaginacia(context))],
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width * 0.50,
                      margin: EdgeInsets.all(20.0),
                      child:
                          myCard(context, color: Colors.white,elevation: 12,shadowColor: Colors.black,radius: 3,
                              child: Container(
                                margin: EdgeInsets.all(15.0),
//                            height: MediaQuery.of(context).size.height * 0.4,
                                child: Center(child: Text(
                                  'Уважаемые пользователи! У Вас есть возможность узнать о'
                                  'положенных Вам льготах, либо проверить себя в базе  данных Самарской области по отдельным льготным категориям. '
                                  'Для проверки учёта, введите свои данные и нажмите кнопку «Проверить»',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 36),
                                ),),
                              )),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Image.asset('assets/family.png'),)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
