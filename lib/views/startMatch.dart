import 'package:flutter/material.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/views/selectPlayers.dart';
import 'package:flutter_app/widgets/animatedButtton.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class StartMatch extends StatefulWidget{

  static String currentTeamName;
  _StartMatch createState() => _StartMatch();

}

class _StartMatch extends State<StartMatch> {

  final _firstTteamName = TextEditingController();
  final _secondTteamName = TextEditingController();
  final _firstTeamCity = TextEditingController();
  final _secondTeamCity = TextEditingController();
  final __typefirstAheadController = TextEditingController();
  final __typesecondAheadController = TextEditingController();
  final _venueCity = TextEditingController();
  final _venuetypeAheadController = TextEditingController();

  double _scale;
  AnimationController _controller;

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
        title: Text("Start Match"),
      ),
      body: Center(
            child: SingleChildScrollView(
              
              padding: EdgeInsets.all(10),
              
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Text("Chose teams"),
                  SizedBox(height: _height * 0.01),

                  typeAhed(_venueCity, _venuetypeAheadController, _width * 0.5),

                  SizedBox(height: _height * 0.05),

                  TextField(
                    controller: _firstTteamName,
                    decoration: inputDecoration("Team A Name"),
                    ),

                  SizedBox(height: _height * 0.01),

                  rowWithCityAndPlayer(__typefirstAheadController, _firstTeamCity, _width * 0.5, _firstTteamName),


                  SizedBox(height: _height * 0.02),

                  rowWithText("VS"),

                  SizedBox(height: _height * 0.02),

                  TextField(
                    controller: _secondTteamName,
                    decoration: inputDecoration("Team B Name"),
                  ),

                  SizedBox(height: _height * 0.01),

                  rowWithCityAndPlayer(__typesecondAheadController, _secondTeamCity, _width * 0.5, _secondTteamName),

                  SizedBox(height: _height * 0.05),

                  SilderButton("Slide to Start a match", _height * 0.09, _width * 0.8, context),
                ],
              ),
            ),
      ),

    );
  }

  inputDecoration(String lable){
    return new InputDecoration(
      labelText: lable,
      fillColor: Colors.white,
      border: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(25.0),
      ),
    );
  }


  rowWithCityAndPlayer(TextEditingController typedValue,  TextEditingController valueController, double cityFiledWidth, TextEditingController teamName){
    return Row(children: <Widget>[
      Container(
        child: typeAhed(typedValue, valueController, cityFiledWidth),
      ),

      Container(
        padding: EdgeInsets.only(left: 20, right: 10),
        child: Column(
          children: <Widget>[
            Container(
                child: RaisedButton.icon(
                  padding: EdgeInsets.all(15),
                    shape :RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                    ),
                    color: Colors.blue,
                    onPressed: (){
                    StartMatch.currentTeamName = teamName.text;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PlayersList()));

                    },
                    icon: Icon(Icons.add, color: Colors.white,),
                    label: Text("Players", style: TextStyle(
                           color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
                     ),
              ),
            ),
          ],
        ),





//        padding: EdgeInsets.only(left: 10),
//        child: SizedBox.fromSize(
//          size: Size(60, 60), // button width and height
//          child: ClipOval(
//            child: Material(
//              color: Colors.orange, // button color
//              child: InkWell(
//                splashColor: Colors.green, // splash color
//                onTap: () {
//
//
//                }, // button pressed
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Icon(Icons.add), // icon
//                    Text("players"), // text
//                  ],
//                ),
//              ),
//            ),
//          ),
//        ),
      )
    ]);
  }

  typeAhed(TextEditingController typedValue,  TextEditingController valueController, double width){
    return Container(
      width: width,
      child: TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
          controller: typedValue,
          decoration: inputDecoration("City"),
        ),
        suggestionsCallback: (pattern) {
          // ignore: missing_return
          if(pattern.isNotEmpty) {
            return DatabaseService().getCity(pattern[0].toUpperCase()+pattern.substring(1));
          }
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        onSuggestionSelected: (suggestion) {
          typedValue.text = suggestion;
          valueController.text = suggestion;
        },
      ),
    );
  }

  rowWithText(String text){
    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: Divider(
              color: Colors.black,
              height: 36,
            )),
      ),
      Container(
            decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
            ),
          child: Text(text,style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
             ),
          padding: EdgeInsets.all(20.0),

      ),
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 20.0, right: 10.0),
            child: Divider(
              color: Colors.black,
              height: 36,
            )),
      ),
    ]);
  }
}