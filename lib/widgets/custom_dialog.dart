
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/match.dart';
import 'package:flutter_app/views/startInning.dart';

class CustomDialog extends StatelessWidget {
  final primaryColor = const Color(0xFF75A2EA);
  final grayColor = const Color(0xFF939393);

  MatchGame matchGame;

  String title, description1, description2, buttonText;


  CustomDialog({this.matchGame, this.title, this.description1, this.description2, this.buttonText});

  static const double padding = 20.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(padding),
      ),
      child: Container(
        height: 350,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(padding),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 10.0),
                    ),
                  ]),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  SizedBox(height: 20.0),
                  AutoSizeText(
                    title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "DansingScript"
                    ),
                  ),
                  SizedBox(height: 20.0),

                  (description1.isNotEmpty) ?
                  AutoSizeText(
                    description1,
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: grayColor,
                      fontSize: 15.0,
                      fontFamily: "Lemonada"
                    ),
                  )
                  : SizedBox(height: 10.0),

                  AutoSizeText(
                    description2,
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: grayColor,
                      fontSize: 15.0,
                      fontFamily: "Lemonada"
                    ),
                  ),

                  SizedBox(height: 20),

                  RaisedButton(
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: AutoSizeText(
                        buttonText,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                          fontFamily: "Lemonada"
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      if(matchGame.isLive) {
                        Navigator.push(context, MaterialPageRoute(builder: (
                            context) => StartInnings(match: matchGame)));
                      }
                      else{
                        Navigator.of(context).pushReplacementNamed('/home');
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
