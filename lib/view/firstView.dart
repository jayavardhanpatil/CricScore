import 'package:flutter/material.dart';
import 'package:flutter_app/view/demo.dart';

class FirstView extends StatelessWidget{

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('LogIn Page'),
        ),
        body: Container(
          child: Container(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("Demo"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Demo()));
                  }
                )
              ],
            ),
          ),
          ),
      );
    }
}