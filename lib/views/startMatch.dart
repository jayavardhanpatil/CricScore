
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:CricScore/model/match.dart';
import 'package:CricScore/model/team.dart';
import 'package:CricScore/views/tossPage.dart';
import 'package:CricScore/views/viewSquad.dart';
import 'package:CricScore/widgets/Search.dart';
import 'package:CricScore/widgets/ToastWidget.dart';
import 'package:CricScore/widgets/gradient.dart';

class StartMatch extends StatefulWidget{

  MatchGame match;

  StartMatch({Key key, @required this.match}) : super (key : key);

  _StartMatch createState() => _StartMatch(match: match);

}

class _StartMatch extends State<StartMatch>{
  MatchGame match;

  Color primaryColor = const Color(0xFF75A2EA);

  _StartMatch({this.match});

  final _matchVenue = TextEditingController();
  final _typedValue = TextEditingController();
  final _oversController = TextEditingController();
  Team team1;
  Team team2;

  @override
  void initState() {

    match.teams.forEach((key, value) {
      if(team1 == null){
        team1 = value;
      }else{
        team2 = value;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final _width = MediaQuery
        .of(context)
        .size
        .width;
    final _height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          "Start match",
          maxLines: 1,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "Lemonada",
            color: Colors.white,

          ),
        ),
        flexibleSpace: getAppBarGradient(),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(


            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(children: <Widget>[
                  Expanded(
                    child: new Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                          margin: const EdgeInsets.only(left: 10.0, right: 20.0),

                          child : AutoSizeText(
                            team1.getTeamName(),
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: "Lemonada",

                            ),
                          ),
                        ),

                        SizedBox(height: _height * 0.03),


                        RaisedButton(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: AutoSizeText(
                              "Team Squad",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w200,
                                color: Colors.white,
                                fontFamily: "Lemonada",
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewSquad(team: team1)));
                          },
                        ),

                      ],

                    ),
                  ),


                  Container(
                    decoration: getButtonGradientColor(BoxShape.circle),
                    child: AutoSizeText(
                      "VS",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "Lemonada",
                        color: Colors.white,

                      ),
                    ),
                    padding: EdgeInsets.all(10.0),

                  ),


                  Expanded(
                    child: new Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                          margin: const EdgeInsets.only(left: 10.0, right: 20.0),

                          child : AutoSizeText(
                            team2.getTeamName(),
                            maxLines: 1,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: "Lemonada",

                            ),
                          ),
                        ),


//                          Text(team2.getTeamName(), textAlign: TextAlign.center, style: TextStyle(
//                              fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 20
//                          ),),),

                        SizedBox(height: _height * 0.03),

                        RaisedButton(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: AutoSizeText(
                              "Team Squad",
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w200,
                                color: Colors.white,
                                fontFamily: "Lemonada",
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewSquad(team: team2)));
                          },
                        ),

                      ],

                    ),
                  ),
                ]),

                SizedBox(height: _height * 0.03),

                Padding(
                  padding:EdgeInsets.symmetric(horizontal:10.0),
                  child:Container(
                    height:1.0,
                    width: _width * 0.8,
                    color:Colors.black,),),


                SizedBox(height: _height * 0.04),

                Container(
                  width: _width * 0.9,
                  child: Column(
                    children: <Widget>[

                      typeAhed(_typedValue, _matchVenue, _width * 0.9, "Match City"),

                      SizedBox(height: _height * 0.01),

                      TextField(
                        //validator: Validator.validate,
                        controller: _oversController,
                        decoration: InputDecoration(
                          labelText: "Total Overs",
                        ),
                        style: TextStyle(fontFamily: "Lemonada",),
                        keyboardType: TextInputType.number,
                      ),

                      SizedBox(height: _height * 0.04),


                      RaisedButton(
                        color: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: AutoSizeText(
                            "Toss Coin",
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              color: Colors.white,
                              fontFamily: "Lemonada",
                            ),
                          ),
                        ),
                        onPressed: () {
                          if(_oversController.text.isEmpty || int.parse(_oversController.text) == 0) {
                            showFailedColoredToast("Overs is mandatory field and should be greater than 0");
                          }else if(_matchVenue.text.isEmpty){
                            showFailedColoredToast("Match Venue is mandatory field please select city");
                          }else{
                            match.totalOvers = int.parse(_oversController.text);
                            match.matchVenue = _matchVenue.text;
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => TossPage(match: match)));
                          }
                        },
                      ),



//                      FlatButton(
//                        onPressed: () {
//                          if(_oversController.text.isEmpty || int.parse(_oversController.text) == 0) {
//                            showFailedColoredToast("Overs is mandatory field and should be greater than 0");
//                          }else if(_matchVenue.text.isEmpty){
//                            showFailedColoredToast("Match Venue is mandatory field please select city");
//                          }else{
//                            match.totalOvers = int.parse(_oversController.text);
//                            match.matchVenue = _matchVenue.text;
//                            Navigator.push(context, MaterialPageRoute(
//                                builder: (context) => TossPage(match: match)));
//                          }
//
//                        },
//                        textColor: Colors.white,
//                        padding: const EdgeInsets.all(0.0),
//                        child: Container(
//                          decoration: getButtonGradientColor(BoxShape.rectangle),
//                          padding: const EdgeInsets.all(10.0),
//                          child: const Text(
//                              'Toss Coin',
//                              style: TextStyle(fontSize: 20)
//                          ),
//                        ),
//                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    throw UnimplementedError();
  }

}