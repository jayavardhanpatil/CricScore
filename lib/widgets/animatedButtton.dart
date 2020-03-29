

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/views/profile.dart';
import 'package:flutter_app/views/startMatch.dart';
import 'package:flutter_app/widgets/loader.dart';
import 'package:slider_button/slider_button.dart';

Widget get animatedButtonUI => Container(
  height: 100,
  width: 250,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(100),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFA7BFE8),
        Color(0xFF6190E8),
      ],
    ),
  ),
  child: Center(
    child: Text(
      'tap!',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ),
);

Widget SilderButton(String text, double height, double width, BuildContext context){

  return SliderButton(
    height: height,
    width: width,
    action: () {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));

    },
    label: Text(
      text,
      style: TextStyle(
          color: Color(0xff4a4a4a), fontWeight: FontWeight.w600, fontSize: 20),
    ),
    icon: Center(
        child:Icon(   Icons.power_settings_new,
          color: Colors.white,
          size: 40.0,
          semanticLabel: 'Text to announce in accessibility modes',
        )),
    buttonColor: Colors.blue,
    backgroundColor: Colors.green,
    highlightedColor: Colors.red,
    baseColor: Colors.amber,
  );

}