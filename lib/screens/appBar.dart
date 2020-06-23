import 'package:flutter/material.dart';
import '../config/theme.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  //const MyAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var marginFixed = MediaQuery.of(context).size.width * 0.040;
    return AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            Container(
                margin: EdgeInsets.only(right: marginFixed*0.9, top: 8.0),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(40.0),
                          bottomLeft: const Radius.circular(40.0),
                          bottomRight: const Radius.circular(40.0)),
                      child: Image.asset('assets/pic.png'),
                    ),
                  ],
                )),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
              icon: Icon(Icons.arrow_back_ios,
              color: StyleCustom.txtSecondry,
              size: 25.0,)
          ));
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
