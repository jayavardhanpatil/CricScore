
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/appStaticBarTitles.dart';
import 'package:flutter_app/model/match.dart';
import 'package:flutter_app/model/team.dart';
import 'package:flutter_app/services/CustomRadioButton.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/views/startInning.dart';
import 'package:flutter_app/widgets/SelectPlayerCustom_dialog.dart';
import 'package:flutter_app/widgets/dialoghelper.dart';
import 'package:flutter_app/widgets/gradient.dart';
import 'package:flutter_app/widgets/loader.dart';
import 'package:slider_button/slider_button.dart';

import 'directSelect.dart';

class TossPage extends StatefulWidget{

  MatchGame match;
  final Function(dynamic) radioButtonValue;

  TossPage({Key key, @required this.match, this.radioButtonValue}) : super (key : key);

  _TossPage createState() => _TossPage(match: match);

}

class _TossPage extends State<TossPage> {
  MatchGame match;

  _TossPage({this.match});

  Team _tossWonteam;
  int currentSelectedIndex = -1;
  String currentSelectedLabel = "";
  List<String> listOfTeams = new List();

  void initState(){
    listOfTeams = buildTeaNamemList();
    super.initState();
  }

  List<String> buildTeaNamemList(){
    List<String> listOfTeams  = new List();
    match.teams.forEach((key, value) {
      listOfTeams.add(key);
    });
    return listOfTeams;
  }

  bool showSlideBar = true;

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
        title: Text("Toss"),
        flexibleSpace: getAppBarGradient(),
      ),

      body: Container(
        child: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Text("Who won the Toss? ", style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17)),
              SizedBox(height: _height * 0.02),

              Column(
                children: <Widget>[

                  CustomRadioButton(
                    hight: _height * 0.1,
                    enableShape: true,
                    elevation: 10,
                    customShape: (
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        )
                    ),
                    buttonColor: Theme.of(context).canvasColor,
                    buttonLables: listOfTeams,
                    buttonValues: listOfTeams,
                    radioButtonValue: (value) {
                      _tossWonteam = match.teams[value];
                      match.setWonTossTeam(value);
                      print(_tossWonteam.getTeamName());
                    },
                    selectedColor: Color(0xFF6190E8),
                  ),
                ],
              ),

              SizedBox(height: _height * 0.05),


              Text("Select the Innings! ", style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17)),
              SizedBox(height: _height * 0.02),


              Column(
                children: <Widget>[
                  CustomRadioButton(
                    hight: _height * 0.1,
                    enableShape: true,
                    elevation: 10,
                    customShape: (
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        )
                    ),
                    buttonColor: Theme.of(context).canvasColor,
                    buttonLables: [StaticString.BATTING_INNING, StaticString.BOWLING_INNING],
                    buttonValues: [StaticString.BATTING_INNING, StaticString.BOWLING_INNING],
                    radioButtonValue: (value) {
                      match.setSelectedInnings(value);
                      print(value);
                    },
                    selectedColor: Color(0xFF6190E8),
                  ),
                ],
              ),

              SizedBox(height: _height * 0.1),

              SilderButton("Slide to Start a match", _height * 0.09, _width * 0.8, context),

            ],
          ),
        ),
      ),
    );

  }


  Widget SilderButton(String text, double height, double width, BuildContext context, ) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              stops: [0.0, 0.7, 1.0],

              colors: <Color>[
                Color(0xFFd60000),
                Color(0xFF6190E8),
                Color(0xFF090979)]
          ),
          borderRadius: BorderRadius.circular(30)),
      alignment: Alignment.centerLeft,

      child: SliderButton(
        dismissible: false,
        vibrationFlag: false,
        height: height,
        width: width,
        action: (){
          print("Overs : "+match.totalOvers.toString());
          print("Toss Won Team : "+match.tossWonTeam);
          print("Selected Innings "+match.selectedInning);

          match.setIsFirstInningsOver(false);
          match.setInning();
          match.isLive = true;
          print(match.firstInning.toJson());
          FutureBuilder(
            future: DatabaseService().addMatch(match),
            builder: (context, snapshot){
              if(snapshot.data == null){
                Loading();
              }else if(snapshot.connectionState == ConnectionState.done){
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("Match Details Added to the server")));
              }
            },
          );

          //Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage_select(match: match)));
          Navigator.push(context, MaterialPageRoute(builder: (context) => StartInnings(match: match)));
        },
        label: Text(
          text,
          style: TextStyle(
              color: Color(0xff4a4a4a), fontWeight: FontWeight.w600, fontSize: 20),
        ),
        icon: Center(
            child:Icon(   Icons.arrow_forward_ios,
              color: Colors.white,
              size: 40.0,
              //semanticLabel: 'Text to announce in accessibility modes',
            )),
        baseColor: Colors.white,
        highlightedColor: Colors.black,
        backgroundColor: Colors.transparent,
        buttonColor: Color(0xFF6190E8),
      ),
    );

  }

  List<Widget> buildButtonsColumn(ShapeBorder shape, double height) {

    List<Widget> buttons = [];
    for (int index = 0; index < listOfTeams.length; index++) {
      var button = Expanded(
        // flex: 1,
        child: Card(
          color: currentSelectedLabel == listOfTeams[index]
              ? Color(0xFF6190E8)
              : null,
          shape: shape,
          child: Container(
            height: height,
            child: MaterialButton(
              shape: shape,
              onPressed: () {
                widget.radioButtonValue(listOfTeams[index]);
                setState(() {
                  currentSelectedIndex = index;
                  currentSelectedLabel = listOfTeams[index];
                });
              },
              child: Text(
                listOfTeams[index],
                style: TextStyle(
                  color: currentSelectedLabel == listOfTeams[index]
                      ? Colors.white
                      : Theme.of(context).textTheme.body1.color,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      );
      buttons.add(button);
    }
    return buttons;
  }
}