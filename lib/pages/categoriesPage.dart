import 'package:firebase/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kul/widgets/MyScaffold.dart';
import 'package:kul/widgets/myCard.dart';

import '../main.dart';
import '../topTabBarSilver.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String url = "privilege";
  String url2 = "razdels";

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
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      myCard(context,
                          color: Colors.white,
                          elevation: 12,
                          shadowColor: Colors.black,
                          radius: 3,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                            Container(
                          margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                              child:Text('Льготы'),),
                            Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            margin: EdgeInsets.all(15.0),
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: StreamBuilder(
                              stream: store.collection(url).onSnapshot,
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasError)
                                  return new Text('Error: ${snapshot.error}');
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return new Text('Loading...');
                                  default:
                                    List<DocumentSnapshot> docsList =
                                        snapshot.data.docs;
                                    return new ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data.docs.length,
                                        itemBuilder:
                                            (BuildContext ctx, int index) {
                                          return Container(
                                            child: buildMYQuestion(context,
                                                docsList.elementAt(index)),
                                          );
                                        });
                                }
                              },
                            ),
                          )]))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        child: myCard(context,
                            color: Colors.white,
                            elevation: 12,
                            shadowColor: Colors.black,
                            radius: 3,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                              Container(
                                margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                                child:Text('Категории'),),
                              Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              margin: EdgeInsets.all(15.0),
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: StreamBuilder(
                                stream: store.collection(url2).onSnapshot,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasError)
                                    return new Text('Error: ${snapshot.error}');
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return new Text('Loading...');
                                    default:
                                      List<DocumentSnapshot> docsList =
                                          snapshot.data.docs;
                                      return new Column(children:[
                                        Container(
                                            margin: EdgeInsets.fromLTRB(0,0,0,10),
                                            child:
                                        StreamBuilder(
                                          stream: store.collection(url2).onSnapshot,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<dynamic> snapshot) {
                                            if (snapshot.hasError)
                                              return new Text('Error: ${snapshot.error}');
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.waiting:
                                                return new Text('Loading...');
                                              default:
                                                List<DocumentSnapshot> docsList =
                                                    snapshot.data.docs;
                                                return new ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: snapshot.data.docs.length,
                                                    itemBuilder:
                                                        (BuildContext ctx, int index) {
                                                      return InkWell(
                                                        onTap: () { setState(() {
                                                          url2 = url2 + "/" + snapshot.data.docs.elementAt(index).id + "/razdels" + '/' + snapshot.data.docs.elementAt(index).id + "/razdels";
                                                        }); },
                                                        child: buildMYQuestion(context,
                                                            docsList.elementAt(index)),
                                                      );
                                                    });
                                            }
                                          },
                                        )),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder:
                                              (BuildContext ctx, int index) {
                                            return InkWell(
                                                onTap: () { setState(() {
                                                  url2 = url2 + "/" + snapshot.data.docs.elementAt(index).id +"/categories";
                                                }); },
                                              child: buildMYQuestion(context,
                                                  docsList.elementAt(index)),
                                            );
                                          })]);
                                  }
                                },
                              ),
                            )])),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMYQuestion(
      BuildContext context, DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data();

    return  Container(child: Text(data["name"]));
  }
}
