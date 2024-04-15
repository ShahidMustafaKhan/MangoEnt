import 'package:flutter/material.dart';

import '../helpers/quick_help.dart';

class LoadingDialog extends Dialog {


  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency,
      child: new Center(
        child: new SizedBox(
          width: 70.0,
          height: 70.0,
          child: new Container(
            decoration: ShapeDecoration(
              //color: Color(0xffffffff),
              color: QuickHelp.isDarkMode(context) ? Color(0xFF000000) : Color(0xFFFFFFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(
                  color: QuickHelp.isDarkMode(context) ? Color(0xFFFFFFF) : Color(0xFFFFC107),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}