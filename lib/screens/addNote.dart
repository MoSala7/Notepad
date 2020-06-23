import 'dart:io';
import 'package:flutter/material.dart';
import '../config/theme.dart';
import './appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import '../models/notes.dart';
import '../models/db_helper.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddNote extends StatefulWidget {
  final String appBarTitle;
  final Note note;
  AddNote({
    Key key,
    @required this.note,
    this.appBarTitle,
  }) : super(key: key);
  _AddNoteState createState() => _AddNoteState(this.note, this.appBarTitle);
}

class _AddNoteState extends State<AddNote> {
  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;

  File _image;
  File _video;
  _AddNoteState(note, this.appBarTitle);
  Future getVideo(ImageSource src) async {
    var video = await ImagePicker.pickVideo(source: src);
    setState(() {
      _video = video;
      _noteController.text += _image.toString();
    });
  }

  Future getImage(ImageSource src) async {
    var image = await ImagePicker.pickImage(source: src);
    setState(() {
      _image = image;
      _noteController.text += _image.toString();
    });
  }

  TextEditingController _noteController = TextEditingController();

  var date = DateFormat.yMMMd().format(new DateTime.now());
  var time = DateFormat.Hm().format(new DateTime.now());

  @override
  Widget build(BuildContext context) {
    _noteController.text = widget.note.description;
    var marginFixed = MediaQuery.of(context).size.width * 0.040;
    var marginFixedTop = MediaQuery.of(context).size.height * 0.040;
    dataPicker() {
      return DatePicker.showDateTimePicker(
        context,
        showTitleActions: true,
        onChanged: (date) {
          debugPrint('change $date');
        },
        onConfirm: (date) {
          debugPrint('confirm $date');
          widget.note.reminder = date.toString().replaceRange(15, 22, '');
          setState(() {
            
          });
        },
        currentTime: (widget.note.reminder == "")? DateTime.now():DateTime.parse(widget.note.reminder) ,
        locale: LocaleType.en,
        theme: DatePickerTheme(
            backgroundColor: StyleCustom.boxColor,
            itemStyle: TextStyle(color: StyleCustom.txtPrimary),
            cancelStyle: TextStyle(
                color: StyleCustom.txtSecondry,
                fontWeight: FontWeight.w500,
                fontSize: 16.0),
            doneStyle: TextStyle(
                color: StyleCustom.blue,
                fontWeight: FontWeight.w500,
                fontSize: 16.0)),
      );
    }

    addReminder() {
      return GestureDetector(
          onTap: () {
            dataPicker();
          },
          child: Container(
              margin: EdgeInsets.fromLTRB(marginFixed * 0, marginFixed * 0.1,
                  marginFixed * 0.5, marginFixed * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          dataPicker();
                        },
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(Icons.add),
                        color: StyleCustom.txtPrimary,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: marginFixed),
                      ),
                      Text(
                        "Add Reminder",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: StyleCustom.txtSecondry),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: marginFixedTop * 0.45,
                            bottom: marginFixedTop * 0.45),
                      ),
                    ],
                  )
                ],
              )));
    }

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
                    widget.appBarTitle,
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w400,
                        color: StyleCustom.txtPrimary),
                    textAlign: TextAlign.start,
                  ),
                  Padding(
                    padding: EdgeInsets.all(marginFixedTop * 0.05),
                  ),
                  Expanded(
                      child: Container(
                          child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 0.0,
                                  spreadRadius: 0.8,
                                  color: StyleCustom.boxShadow.withAlpha(80))
                            ],
                            color: StyleCustom.boxColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18.0),
                                bottomRight: Radius.circular(18.0)),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            margin: EdgeInsets.fromLTRB(marginFixed * 0.5, 0.0,
                                marginFixed * 0.5, marginFixed * 0.5),
                            child: CupertinoTextField(
                              clearButtonMode: OverlayVisibilityMode.always,
                              enableInteractiveSelection: true,
                              expands: true,
                              controller: _noteController,
                              style: TextStyle(
                                  color: StyleCustom.txtPrimary,
                                  fontSize: 16.0),
                              maxLines: null,
                              minLines: null,
                              placeholder: 'write your note here',
                              decoration: BoxDecoration(),
                              /*decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      color: StyleCustom.txtSecondry),
                                  border: InputBorder.none,
                                  hintText: 'write your note here',
                                ),*/
                              onChanged: (String value) {
                                debugPrint(_noteController.text);
                                updateDescription();
                              },
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(5.0)),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 0.0,
                                  spreadRadius: 0.8,
                                  color: StyleCustom.boxShadow.withAlpha(80))
                            ],
                            color: StyleCustom.boxColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(18.0),
                                bottomRight: Radius.circular(18.0)),
                          ),
                          child: new ListView.builder(
                              itemCount: 1,
                              primary: false,
                              shrinkWrap: true,
                              itemBuilder:
                                  (BuildContext context, int position) {
                                if (widget.note.reminder == "") {
                                  return addReminder();
                                } else {
                                  return GestureDetector(
                                      onTap: () {
                                        dataPicker();
                                      },
                                      child: Container(
                                          margin: EdgeInsets.fromLTRB(
                                              marginFixed * 0,
                                              marginFixed * 0.1,
                                              marginFixed * 0.5,
                                              marginFixed * 0.1),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  IconButton(
                                                    highlightColor:
                                                        Colors.transparent,
                                                    splashColor:
                                                        Colors.transparent,
                                                    onPressed: () {
                                                      widget.note.reminder = "";
                                                      setState(() {});
                                                    },
                                                    icon: Icon(Icons.close),
                                                    color: StyleCustom.red,
                                                    iconSize: 20,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: marginFixed),
                                                  ),
                                                  Text(
                                                    widget.note.reminder,
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: StyleCustom
                                                            .txtPrimary,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: marginFixedTop *
                                                            0.45,
                                                        bottom: marginFixedTop *
                                                            0.45),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )));
                                }
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.all(marginFixedTop * 0.15),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 0.0,
                                  spreadRadius: 0.8,
                                  color: StyleCustom.boxShadow.withAlpha(80))
                            ],
                            color: StyleCustom.boxColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(18.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  getImage(ImageSource.camera);
                                },
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                icon: Image.asset("assets/camera.png",
                                    width: 22, color: StyleCustom.blue),
                              ),
                              IconButton(
                                onPressed: () {
                                  getImage(ImageSource.gallery);
                                  debugPrint(_noteController.text);
                                },
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                icon: Image.asset("assets/photo.png",
                                    width: 22, color: StyleCustom.blue),
                              ),
                              IconButton(
                                onPressed: () {
                                  getVideo(ImageSource.gallery);
                                },
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                icon: Image.asset("assets/video.png",
                                    width: 20, color: StyleCustom.blue),
                              ),
                              IconButton(
                                onPressed: () {},
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                icon: Image.asset("assets/attach.png",
                                    width: 20, color: StyleCustom.blue),
                              ),
                              IconButton(
                                onPressed: () {},
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                icon: Image.asset("assets/microphone.png",
                                    width: 20, color: StyleCustom.blue),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )))
                ])),
      ),
      backgroundColor: StyleCustom.bg,
      bottomNavigationBar: Container(
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                if (_noteController.text != "") {
                  _save();
                } else {
                  await helper.deleteNote(widget.note.id);
                  Navigator.pop(context);
                }
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: StyleCustom.blue,
                  height: 55.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text(
                        widget.appBarTitle,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void updateDescription() {
    widget.note.description = _noteController.text;
  }

  void _save() async {
    widget.note.date = DateFormat.yMMMd().format(DateTime.now());
    widget.note.time = DateFormat.Hm().format(DateTime.now());
    if (widget.note.id != null) {
      // Case 1: Update operation
      await helper.updateNote(widget.note);
    } else {
      // Case 2: Insert Operation
      await helper.insertNote(widget.note);
    }
    Navigator.pop(context);
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
