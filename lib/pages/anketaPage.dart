import 'package:firebase/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kul/widgets/MyScaffold.dart';
import 'package:kul/widgets/myCard.dart';

import '../main.dart';
import '../topTabBarSilver.dart';
import 'mylgotsPage.dart';

class AnketaPage extends StatefulWidget {
  @override
  _AnketaPageState createState() => _AnketaPageState();
}

class _AnketaPageState extends State<AnketaPage> {

  String url = "questionTest";
  List<String> lgotsList = [];

  @override
  Widget build(BuildContext context) {
    return buildMyScaffold(
        context,
        MainCollapsingToolbar(
          expandleHeight: 300,
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
      body: Column(
        children: [
        myPaginacia(context),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20.0) ,
                  child: Column(
                    children: [
                      myCard(context, color: Colors.white,elevation: 12,shadowColor: Colors.black,radius: 30,
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.8,
                            margin: EdgeInsets.all(15.0) ,
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: StreamBuilder(
                              stream: store.collection(url).onSnapshot,
                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                                if (snapshot.hasError)
                                  return new Text('Error: ${snapshot.error}');
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting: return new Text('Loading...');
                                  default:
                                   List<DocumentSnapshot> docsList = snapshot.data.docs;
                                   docsList.forEach((element) {
                                     if (element.id =="lgots") {
                                       Map <String, dynamic> mapData = element.data();

                                       List<String> idslgotsStrings =[];
                                       mapData.forEach((key, value) {
                                         idslgotsStrings.add(value);
                                       });
                                       lgotsList.addAll(idslgotsStrings);
                                     }
                                   });

                                    return  Container(child: Row(children: <Widget>[
                                      Expanded(
                                        child:  ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount:  snapshot.data.docs.length,
                                          itemBuilder: (BuildContext ctx, int index) {
                                            DocumentSnapshot doc =docsList.elementAt(index);
                                            if (doc.id =="lgots") {
                                              return Container();
                                            }
                                            return  Container(
                                              child: buildMYQuestion( context ,  doc),
                                            );
                                          }
                                      ),),
                                      Expanded(child: Container(child: Image.asset('assets/family.png'),),),
                                      Expanded(
                                          child:  Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(18),
                                                border: Border.all(
                                                color: Colors.blue,
                                                width: 2,
                                                style: BorderStyle.solid)),
                                            height: MediaQuery.of(context).size.height * 0.6,
                                            width: MediaQuery.of(context).size.height * 0.4,
                                            child: Container(
                                              margin: EdgeInsets.all(10),
                                              child: FlatButton(
                                              onPressed: () {
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                              print( "lg" +lgotsList.toString() );
                                              return myLgotsPage(lgotsList);
                                              }));
                                               },
                                                child: Text( "Доступные льготы:" + lgotsList.length.toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),),),),)

                                    ],),);
                                }
                              },),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget  buildMYQuestion (BuildContext context, DocumentSnapshot documentSnapshot) {

    Map <String, dynamic> data = documentSnapshot.data();
    List<dynamic> answers = data["answers"]?? [];

    return Container ( child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Container( child: Text(data["name"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.black), ),),

          Container(
            height:  MediaQuery.of(context).size.height*0.2,
            width: MediaQuery.of(context).size.width*0.9,
            child: ListView.builder(

              scrollDirection: Axis.horizontal,
              itemCount: answers.length,

                itemBuilder: (context, item) {
                  // ignore: missing_required_param
                  return Container(
                    margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                              color: Colors.red,
                              width: 1,
                              style: BorderStyle.solid)),
                    child: FlatButton( child: Center(
                        child: Text(answers[item].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),),),
                      onPressed: () {
                          setState(() {
                            url = url + "/" + documentSnapshot.id + "/" + item.toString();
                          });
                      },
                    ),
                  );
                }),
          ),


    ],));
  }
}
