import 'package:flutter/cupertino.dart';
import 'package:kul/widgets/MyScaffold.dart';

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
}