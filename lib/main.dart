import 'package:aionote/screens/myTodo.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/myNotes.dart';

void main() {
       runApp(MyApp());}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'aio note',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Myriad-Pro',
      ),
      routes: {
        '/myNotes': (context) => MyNotes(),
        //'/myTodo': (context) => MyTodo(),
      },
      home: Home(),
    );
  }
}
