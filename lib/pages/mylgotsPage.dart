import 'package:firebase/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kul/widgets/MyScaffold.dart';
import 'package:kul/widgets/myCard.dart';

import '../main.dart';
import '../topTabBarSilver.dart';

class myLgotsPage extends StatefulWidget {
  List<String> idsLgots;
  myLgotsPage(this.idsLgots);

  @override
  _myLgotsPageState createState() => _myLgotsPageState();
}

class _myLgotsPageState extends State<myLgotsPage> {

  String url = "privilege";
  List<DocumentSnapshot> lgotsList = [];

  @override
  void initState() {
         widget.idsLgots.forEach((element) {
           print( element );
           store.collection(url).doc(element).get().then((value) {
             print( value.data().toString() );
             if (value.data().isNotEmpty)
               {
                 setState(() {
                   lgotsList.add(value);
                 });
               }
             print( "lgots" + lgotsList.length.toString() );

           });

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
                                child: Container(child: Row(children: <Widget>[
                                  Expanded( flex: 3,
                                    child:  ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:  lgotsList.length,
                                        itemBuilder: (BuildContext ctx, int index) {
                                          DocumentSnapshot doc = lgotsList.elementAt(index);

                                          return  Container(
                                            child: buildMYQuestion( context ,  doc),
                                          );
                                        }
                                    ),),
                                  Expanded(child:
                                  FlatButton(
                                    onPressed: () {

                                    },
                                    child:  Container(
                                      height: MediaQuery.of(context).size.height * 0.3,
                                      child: Text( " Доступно льгот: " + lgotsList.length.toString()),),
                                  )
                                    ,)
                                ],),),
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
