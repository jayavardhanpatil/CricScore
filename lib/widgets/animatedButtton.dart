

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

