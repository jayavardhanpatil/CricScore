import 'package:flutter/material.dart';

class FirstView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('LogIn Page'),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Email',),
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                RaisedButton(
                  child: Text('Login', style: TextStyle(fontSize: 20),),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}