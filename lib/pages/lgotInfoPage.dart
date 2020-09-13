import 'package:firebase/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kul/widgets/MyScaffold.dart';
import 'package:kul/widgets/myCard.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../topTabBarSilver.dart';

class LgotInfoPage extends StatefulWidget {
  String lgotID;
  LgotInfoPage(this.lgotID);

  @override
  _LgotInfoPageState createState() => _LgotInfoPageState();
}

class _LgotInfoPageState extends State<LgotInfoPage> {

  String url = "privilege";
  Map <String, dynamic> lgotaData;

  @override
  void initState() {
    store.collection(url).doc(widget.lgotID).get().then((value) {
      if (value.data().isNotEmpty)
      {
        setState(() {
          lgotaData = value.data();
        });
      }

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildMyScaffold(
        context,
        buildMyHome(context),
        "Главная",
        isAppbar: false);
  }

  Widget buildLgotInfo(context) {
    List<dynamic> documentsList =   lgotaData ["zav"]?? [];

    return Row(children: <Widget>[
      Expanded( flex: 3, child: Container( height: MediaQuery.of(context).size.height*0.7 ,
        child: Column(children: <Widget>[
          Padding (padding: EdgeInsets.all(20.0),
          child: Text(lgotaData['name']?? "" ) ,),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height*0.3,
                child: SingleChildScrollView(child: Container(child: Text(lgotaData['text']?? "")),)),
          )

        ],),

      ) ,),
      Expanded( flex: 1, child: Container(child:
        Column(children: <Widget>[
          Padding( padding: EdgeInsets.all(15.0), child: Text("Документы"),),
          Expanded(child: ListView.builder(
            itemCount: documentsList.length,
            itemBuilder: (context, item) {
              return Container(height:110,  decoration: BoxDecoration(border: Border.all(
                color: Colors.blue, width: 3.0, ),
                borderRadius: BorderRadius.circular(18),
              ), child: Column( children: <Widget>[
                Padding( padding: EdgeInsets.all(8.0), child:  Text(documentsList[item]["name"]?? ""),),
                Container( height: 40 , child: Row  (  mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[FlatButton(onPressed:
                      () async {
                    String   url = documentsList[item]["url"];
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                },
                child: Text("образец" , style: TextStyle(color:  Colors.blue),), ),

                  FlatButton(onPressed: () async {
                   String   url = documentsList[item]["url2"];
                    if (await canLaunch(url)) {
                    await launch(url);
                    } else {
                    throw 'Could not launch $url';
                    }

                  },
                    child: Text("шаблон", style: TextStyle(color:  Colors.red)), )
                ],))
              ],) );
          },),)
        ],)
        ) ,),

    ],);
  }

  Widget buildMyHome(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
        myPaginacia(context),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(20.0) ,
                    child: Column(
                      children: [
                        Expanded(
                          child: myCard(context, color: Colors.white,elevation: 12,shadowColor: Colors.black,radius: 30,
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.8,
                                margin: EdgeInsets.all(15.0) ,
                                height: MediaQuery.of(context).size.height * 0.8,
                                child:  lgotaData==null? Container(child: Center(child: Text("Загрузка"),),) : buildLgotInfo(context)
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget  buildMYQuestion (BuildContext context, DocumentSnapshot documentSnapshot) {
    Map <String, dynamic> data = documentSnapshot.data();
    String name = "";
    try {
      name = data["name"];
    } catch (ex) {
      print("ex " + ex.toString());
    }

    return Container ( child: FlatButton( child: Container(

        width: MediaQuery.of(context).size.width*0.7,

        padding: EdgeInsets.all(20.0),

        child: Text(name)),
      onPressed: () {

      },
    ));
  }
}
