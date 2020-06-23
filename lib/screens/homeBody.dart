import 'package:flutter/material.dart';
import '../config/theme.dart';
import 'package:intl/intl.dart';

class HomeBody extends StatefulWidget {
  HomeBody({Key key}) : super(key: key);
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  var now = new DateTime.now();
  @override
  Widget build(BuildContext context) {
    var marginFixed = MediaQuery.of(context).size.width * 0.040;
    var marginFixedTop = MediaQuery.of(context).size.height * 0.040;
    return SafeArea(
        child: Container(
      margin: EdgeInsets.only(left: marginFixed, right: marginFixed),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Hello",
            style: TextStyle(
                fontSize: 60,
                fontFamily: 'Myriad-Pro',
                fontWeight: FontWeight.w400,
                color: StyleCustom.txtPrimary),
            textAlign: TextAlign.start,
          ),
          Text(
            "Mohamed",
            style: TextStyle(
                fontSize: 55,
                fontWeight: FontWeight.w500,
                color: StyleCustom.txtPrimary),
            textAlign: TextAlign.start,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 0.0),
          ),
          Row(
            children: <Widget>[
              Text(
                getDay(),
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: StyleCustom.txtSecondry),
                textAlign: TextAlign.start,
              ),
              Text(
                getDate(),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: StyleCustom.txtSecondry),
                textAlign: TextAlign.start,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 25.0),
          ),
          Expanded(
            child: Container(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: GridView.count(
                  primary: false,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  crossAxisCount: 2,
                  children: List.generate(4, (index) {
                    return Container(
                      padding: EdgeInsets.all(1.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,TabBar.pagesRoutes[index],);
                        },
                        child: Container(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: marginFixedTop * 0.7, left: marginFixed),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ImageIcon(
                                  AssetImage(TabBar.icons[index]),
                                  color: TabBar.colors[index],
                                  size: 28.0,
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.all(marginFixedTop * 0.7)),
                                Text(
                                  TabBar.titles[index],
                                  style: TextStyle(
                                      color: StyleCustom.txtPrimary,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(marginFixed * 0.3)),
                                Text(
                                  "3 ${TabBar.subTitles[index]}",
                                  style: TextStyle(
                                      color: StyleCustom.txtSecondry,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(25.0)),
                              color: StyleCustom.boxColor,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 0.0,
                                    spreadRadius: 0.8,
                                    color: StyleCustom.boxShadow.withAlpha(80))
                              ]),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

getDate() {
  var day = new DateFormat.d().format(new DateTime.now()).toString();
  var month = new DateFormat.MMMM().format(new DateTime.now()).toString();
  var dayAfter;
  if (day == "1" || day == "21" || day == "31") {
    dayAfter = "st";
  } else if (day == "2" || day == "22") {
    dayAfter = "st";
  } else if (day == "3" || day == "23") {
    dayAfter = "rd";
  } else {
    dayAfter = "th";
  }
  return ("$day$dayAfter $month");
}

getDay() {
  return (DateFormat.EEEE().format(new DateTime.now()).toString() + ",");
}

class TabBar {
  static var icons = [
    "assets/note.png",
    "assets/todo.png",
    "assets/money.png",
    "assets/event.png",
  ];
  static var colors = [
    StyleCustom.blue,
    StyleCustom.orange,
    StyleCustom.green,
    StyleCustom.cyan
  ];
  static var titles = ["Notes", "To Do", "Finance", "Events"];
  static var subTitles = ["notes", "lists", "cards", "events"];
  static var pagesRoutes = ['/myNotes','/myTodo','/myNotes','/myNotes'];
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
