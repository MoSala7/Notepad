/*import 'package:flutter/material.dart';
import '../config/theme.dart';
import './appBar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'addNote.dart';

class MyTodo extends StatefulWidget {
  MyTodo({Key key}) : super(key: key);
  _MyTodoState createState() => _MyTodoState();
}

class _MyTodoState extends State<MyTodo> {
  int count = 2;

  final SlidableController slidableController = SlidableController();
  String dropdownValue = 'Time Created';
  @override
  Widget build(BuildContext context) {
    var marginFixed = MediaQuery.of(context).size.width * 0.040;
    var marginFixedTop = MediaQuery.of(context).size.height * 0.040;
    return Scaffold(
      appBar: MyAppBar(),
      body: SafeArea(
          child: Container(
              margin: EdgeInsets.only(left: marginFixed, right: marginFixed),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "To Do",
                      style: TextStyle(
                          fontSize: 50,
                          fontFamily: 'Myriad-Pro',
                          fontWeight: FontWeight.w400,
                          color: StyleCustom.txtPrimary),
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        DropdownButton<String>(
                          iconEnabledColor: StyleCustom.blue,
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          value: dropdownValue,
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['Time Created', "ToDo's Time"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    letterSpacing: 0.2,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: StyleCustom.txtSecondry),
                              ),
                            );
                          }).toList(),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Sort By : ",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: StyleCustom.txtSecondry),
                            ),
                            Container(
                              child: DropdownButton<String>(
                                iconEnabledColor: StyleCustom.blue,
                                underline: Container(
                                  color: Colors.transparent,
                                ),
                                value: dropdownValue,
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                                items: <String>[
                                  'Time Created',
                                  "ToDo's Time"
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: StyleCustom.txtSecondry),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(marginFixedTop * 0.05),
                    ),
                    Flexible(
                      child: ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: count,
                              itemBuilder:
                                  (BuildContext context, int position) {
                                return Slidable(
                                  key: Key("aa"),
                                  controller: slidableController,
                                  actionPane: SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.22,
                                  child: GestureDetector(
                                    onTap: () {
                                      navigateToDetial(
                                        'Edit Note',
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: StyleCustom.boxColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color: StyleCustom.boxShadow
                                                  .withAlpha(80),
                                              spreadRadius: 0.8,
                                            )
                                          ]),
                                      margin: EdgeInsets.only(
                                          bottom: marginFixed * 0.5),
                                      child: ListTile(
                                        isThreeLine: true,
                                        leading: GestureDetector(onTap: (){debugPrint("circle tapped");},
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            foregroundColor: StyleCustom.green,
                                            child: ImageIcon(
                                              AssetImage("assets/circle0.png"),
                                            ),
                                          ),
                                        ),
                                        title: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 9,
                                              child: Text(
                                                'Title for the notesdsd writed here sdsd',
                                                //this.noteList[position].data,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        StyleCustom.txtPrimary),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(),
                                            )
                                          ],
                                        ),
                                        subtitle: Column(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(top: 2.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    "tag written here",
                                                    style: TextStyle(
                                                        color: StyleCustom
                                                            .txtSecondry),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 7.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 5),
                                                          child: ImageIcon(
                                                            AssetImage(
                                                                "assets/event.png"),
                                                            color: StyleCustom
                                                                .txtSecondry,
                                                            size: 14,
                                                          )),
                                                      Text(
                                                        'Date',
                                                        style: TextStyle(
                                                            color: StyleCustom
                                                                .txtSecondry),
                                                      ),
                                                    ],
                                                  ),
                                                  
                                                  Row(
                                                    children: <Widget>[
                                                      Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 5),
                                                          child: ImageIcon(
                                                            AssetImage(
                                                                "assets/timer.png"),
                                                            color: StyleCustom
                                                                .txtSecondry,
                                                            size: 14,
                                                          )),
                                                      Text(
                                                        'Time',
                                                        style: TextStyle(
                                                            color: StyleCustom
                                                                .txtSecondry),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  secondaryActions: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: marginFixed * 0.5),
                                      child: IconSlideAction(
                                        caption: 'Reminder',
                                        color: Colors.blue,
                                        icon: Icons.timer,
                                        onTap: () => debugPrint('Archive'),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: marginFixed * 0.5),
                                      child: IconSlideAction(
                                        caption: 'Delete',
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: () {},
                                      ),
                                    ),
                                  ],
                                );
                              })),
                    )
                  ]))),
      backgroundColor: StyleCustom.bg,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 0.30),
                decoration: BoxDecoration(
                    color: StyleCustom.boxColor,
                    boxShadow: [
                      BoxShadow(
                        color: StyleCustom.boxShadow.withAlpha(80),
                        spreadRadius: 0.8,
                      )
                    ],
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(15.0))),
                height: 55.0,
                child: Row(
                  children: <Widget>[
                    FlatButton(
                        onPressed: () {},
                        padding: EdgeInsets.only(top: 9.0),
                        child: Column(
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              color: StyleCustom.txtPrimary,
                              size: 21,
                            ),
                            Text(
                              "All",
                              style: TextStyle(
                                  color: StyleCustom.txtSecondry,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        )),
                    FlatButton(
                        onPressed: () => {},
                        padding: EdgeInsets.only(top: 9.0),
                        child: Column(
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            ImageIcon(
                              AssetImage("assets/circle0.png"),
                              color: StyleCustom.txtPrimary,
                              size: 21,
                            ),
                            Text(
                              "un-completed",
                              style: TextStyle(
                                  color: StyleCustom.txtSecondry,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        )),
                    FlatButton(
                        onPressed: () => {},
                        padding: EdgeInsets.only(top: 9.0),
                        child: Column(
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            ImageIcon(
                              AssetImage("assets/circle1.png"),
                              color: StyleCustom.txtPrimary,
                              size: 21,
                            ),
                            Text(
                              "Completed",
                              style: TextStyle(
                                  color: StyleCustom.txtSecondry,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        )),
                  ],
                )),
            Row(
              children: <Widget>[
                Container(
                    height: 55.0,
                    //margin: EdgeInsets.only(top: 0.30),
                    decoration: BoxDecoration(
                        color: StyleCustom.blue,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0))),
                    child: FlatButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () {
                        navigateToDetial(
                          'Add Note',
                        );
                      },
                      //padding: EdgeInsets.only(top: 9.0),
                      child: Icon(
                        Icons.add,
                        size: 28,
                        color: Colors.white,
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  navigateToDetial(String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddNote(appBarTitle: title),
        ));
  }

  Icon getStarred(int star) {
    switch (star) {
      case 1:
        return Icon(
          Icons.star_border,
          size: 22.0,
          color: StyleCustom.orange,
        );
        break;
      case 2:
        return Icon(
          Icons.star,
          size: 22.0,
          color: StyleCustom.orange,
        );
        break;
      default:
        return Icon(
          Icons.star_border,
          size: 22.0,
          color: StyleCustom.orange,
        );
    }
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
*/