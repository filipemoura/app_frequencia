import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future push(BuildContext context, Widget page, {bool replace = false}) {
  if(replace) {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext buildContext) {
      return page;
    }));
  }

  return Navigator.push(context, MaterialPageRoute(builder: (BuildContext buildContext) {
    return page;
  }));
}

pop(BuildContext context) {
  Navigator.pop(context);
}