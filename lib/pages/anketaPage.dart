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
                                      Expanded( flex: 3,
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
                                      Expanded(child:
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                              print( "lg" +lgotsList.toString() );
                                              return myLgotsPage(lgotsList);
                                            }));
                                          },
                                          child:  Container(
                                            height: MediaQuery.of(context).size.height * 0.3,
                                            child: Text( " Доступно льгот: " + lgotsList.length.toString()),),
                                        )
                                        ,)



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

    return Container ( child: Column(children: <Widget>[
      Container( child: Text(data["name"] ),),

          Container(
            height:  MediaQuery.of(context).size.height*0.2,
            width: MediaQuery.of(context).size.width*0.9,
            child: ListView.builder(

              scrollDirection: Axis.horizontal,
              itemCount: answers.length,

                itemBuilder: (context, item) {
                  // ignore: missing_required_param
                  return FlatButton( child: Center(child: Container(

                      child: Text(answers[item].toString())),),
                    onPressed: () {
                        setState(() {
                          url = url + "/" + documentSnapshot.id + "/" + item.toString();
                        });
                    },
                  );
                }),
          ),


    ],));
  }
}
