import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../config/theme.dart';
import './appBar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'addNote.dart';
import '../models/notes.dart';
import '../models/db_helper.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class MyNotes extends StatefulWidget {
  MyNotes({Key key}) : super(key: key);
  _MyNotesState createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;
  int starred = 1;

  final SlidableController slidableController = SlidableController();
  String dropdownValue = 'Newest';
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
                      "Notes",
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
                        Text(
                          "All Notes ($count)",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: StyleCustom.txtSecondry),
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
                                  'Newest',
                                  'Oldest'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  updateListView(this.dropdownValue);
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
                                      navigateToDetail(
                                          this.noteList[position], 'Edit Note');
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
                                        title: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 8,
                                              child: Text(
                                                this
                                                    .noteList[position]
                                                    .description,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        StyleCustom.txtPrimary),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    if(this.noteList[position].star == 1){
                                                    this.noteList[position].star = 2;
                                                    databaseHelper.updateNote(noteList[position]);}
                                                    else if(this.noteList[position].star == 2){
                                                      this.noteList[position].star = 1;
                                                    databaseHelper.updateNote(noteList[position]);
                                                    }
                                                    setState(() {});
                                                  },
                                                  child: getStarred(this
                                                      .noteList[position]
                                                      .star)),
                                            ),
                                          ],
                                        ),
                                        subtitle: Container(
                                          margin: EdgeInsets.only(top: 7.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                this.noteList[position].date,
                                                style: TextStyle(
                                                    color: StyleCustom
                                                        .txtSecondry),
                                              ),
                                              Text(this.noteList[position].time,
                                                  //this.noteList[position].timeCreated,
                                                  style: TextStyle(
                                                      color: StyleCustom
                                                          .txtSecondry))
                                            ],
                                          ),
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
                                        onTap: () {
                                          return DatePicker.showDateTimePicker(
                                            context,
                                            showTitleActions: true,
                                            onChanged: (date) {
                                              debugPrint('change $date');
                                            },
                                            onConfirm: (date) {
                                              debugPrint('confirm $date');
                                              noteList[position].reminder = date
                                                  .toString()
                                                  .replaceRange(15, 22, '');
                                              databaseHelper.updateNote(
                                                  noteList[position]);
                                              setState(() {});
                                            },
                                            currentTime:
                                                (noteList[position].reminder ==
                                                        "")
                                                    ? DateTime.now()
                                                    : DateTime.parse(
                                                        noteList[position]
                                                            .reminder),
                                            locale: LocaleType.en,
                                            theme: DatePickerTheme(
                                                backgroundColor:
                                                    StyleCustom.boxColor,
                                                itemStyle: TextStyle(
                                                    color:
                                                        StyleCustom.txtPrimary),
                                                cancelStyle: TextStyle(
                                                    color:
                                                        StyleCustom.txtSecondry,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.0),
                                                doneStyle: TextStyle(
                                                    color: StyleCustom.blue,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.0)),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: marginFixed * 0.5),
                                      child: IconSlideAction(
                                        caption: 'Delete',
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: () {
                                          _delete(context, noteList[position]);
                                        },
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
                        onPressed: () {
                          starred = 1;
                          setState(() {});
                        },
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
                        onPressed: () {
                          starred = 2;
                          setState(() {});
                        },
                        padding: EdgeInsets.only(top: 9.0),
                        child: Column(
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: StyleCustom.txtPrimary,
                              size: 21,
                            ),
                            Text(
                              "Starred",
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
                        navigateToDetail(Note('', '', 1, '', ''), 'Add Note');
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
    }
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      updateListView(this.dropdownValue);
    }
  }

  void navigateToDetail(Note note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddNote(
        note: note,
        appBarTitle: title,
      );
    }));

    if (result == true) {
      updateListView(this.dropdownValue);
    }
  }

  void updateListView(String order) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      if (order == "Newest") {
        Future<List<Note>> noteListFuture = databaseHelper.getNoteList(starred);
        noteListFuture.then((noteList) {
          setState(() {
            this.noteList = noteList;
            this.count = noteList.length;
          });
        });
      } else if (order == "Oldest") {
        Future<List<Note>> noteListFuture =
            databaseHelper.getNoteListReversed(starred);
        noteListFuture.then((noteList) {
          setState(() {
            this.noteList = noteList;
            this.count = noteList.length;
          });
        });
      }
    });
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
