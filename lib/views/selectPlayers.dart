

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/views/startMatch.dart';

class PlayersList extends StatefulWidget {

  @override
  _PlayersList createState() =>
      _PlayersList();
  }

  class _PlayersList extends State<PlayersList> {
    int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${StartMatch.currentTeamName} selected(" + "${_count}" + ")"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[

              Text("Text"),

            ],
          ),
        ),
      ),
    );
  }

}