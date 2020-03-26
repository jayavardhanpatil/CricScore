import 'package:flutter/material.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/widgets/animatedButtton.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:slider_button/slider_button.dart';

class StartMatch extends StatefulWidget{

  _StartMatch createState() => _StartMatch();

}


class _StartMatch extends State<StartMatch> {

  final _firstTteamName = TextEditingController();
  final _secondTteamName = TextEditingController();
  final _firstTeamCity = TextEditingController();
  final _secondTeamCity = TextEditingController();
  final __typefirstAheadController = TextEditingController();
  final __typesecondAheadController = TextEditingController();

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
      body: Container(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Text("Chose teams"),
                SizedBox(height: _height * 0.05),

                TextField(
                  controller: _firstTteamName,
                  decoration: inputDecoration("Team A Name"),
                  ),

                SizedBox(height: _height * 0.01),

                typeAhed(__typefirstAheadController, _firstTeamCity, "City"),

                SizedBox(height: _height * 0.02),

                rowWithText("VS"),

                SizedBox(height: _height * 0.02),

                TextField(
                  controller: _secondTteamName,
                  decoration: inputDecoration("Team A Name"),
                ),

                SizedBox(height: _height * 0.01),

                typeAhed(__typesecondAheadController, _secondTeamCity, "City"),

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
        borderSide: new BorderSide(
        ),
      ),
    );
  }

  typeAhed(TextEditingController typedValue,  TextEditingController valueController, String lable){
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: typedValue,
        decoration: inputDecoration(lable),
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
          child: Text(text),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          )
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