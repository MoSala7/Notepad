import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import 'homeBody.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    StyleCustom();
    var marginFixed = MediaQuery.of(context).size.width * 0.040;
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(preferredSize: Size.fromHeight(60.0),child:AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            Container(
                margin: EdgeInsets.only(right: marginFixed*0.5, top: 8.0),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(40.0),
                          bottomLeft: const Radius.circular(40.0),
                          bottomRight: const Radius.circular(40.0)),
                      child: Image.asset('assets/pic.png'),
                    ),
                    PopupMenuButton<String>(
                      icon: Icon(
                        Icons.ac_unit,
                        color: Colors.transparent,
                      ),
                      onSelected: choiceAction,
                      itemBuilder: (BuildContext context) {
                        return Constants.choices.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    )
                  ],
                )),
          ],
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: StyleCustom.txtSecondry,
              size: 30.0,
            ),
          )),),
      body: HomeBody(),
      drawer: Container(
        color: StyleCustom.boxColor,
        width: MediaQuery.of(context).size.width*0.7,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text("Header"),
            ),
            //AboutListTile(child: Text("About Screen")),
            ListTile(
              leading: Image.asset("assets/coffe.png",color: StyleCustom.txtPrimary,width: 20.0,),
              title: Text("Donate",style: TextStyle(color: StyleCustom.txtPrimary,fontSize: 16),),
              onTap: () {},
            ),ListTile(
              leading: Icon(Icons.star_border,size: 20,color: StyleCustom.txtPrimary,),
              title: Text("Share",style: TextStyle(color: StyleCustom.txtPrimary,fontSize: 16),),
              onTap: () {},
            ),ListTile(
              leading: Icon(Icons.share,size: 20,color: StyleCustom.txtPrimary,),
              title: Text("Rate",style: TextStyle(color: StyleCustom.txtPrimary,fontSize: 16),),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.adjust,size: 20,color: StyleCustom.txtPrimary,),
              title: Text("Light Theme",style: TextStyle(color: StyleCustom.txtPrimary,fontSize: 16),),
              onTap: () {
                setState(() {
                  StyleCustom.setThemeStyle(0);
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.adjust,size: 20,color: StyleCustom.txtPrimary,),
              title: Text("Dark Theme",style: TextStyle(color: StyleCustom.txtPrimary,fontSize: 16),),
              onTap: () {
                setState(() {
                  StyleCustom.setThemeStyle(1);
                });
              },
            ),ListTile(
              leading: Icon(Icons.adjust,size: 20,color: StyleCustom.txtPrimary,),
              title: Text("Black Theme",style: TextStyle(color: StyleCustom.txtPrimary,fontSize: 16),),
              onTap: () {
                setState(() {
                  StyleCustom.setThemeStyle(2);
                });
              },
            ),Divider(),
            signMe(),
            RaisedButton(child: Text("click me"),onPressed: (){pushNotification();}),
          ],
        ),
      ),
      backgroundColor: StyleCustom.bg,
    );
  }

pushNotification() async{
  
}
signMe(){
  return ListTile(
              leading: Icon(Icons.adjust,size: 20,color: StyleCustom.txtPrimary,),
              title: Text("Sign out",style: TextStyle(color: StyleCustom.txtPrimary,fontSize: 16),),
              onTap: () {
                setState(() {
                });
              },
            );
}

  void choiceAction(String choice) {
    if (choice == Constants.cname) {
      print('Settings');
    } else if (choice == Constants.cphoto) {
      print('Subscribe');
    }
  }
}
