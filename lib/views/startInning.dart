
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/gradient.dart';

class StartInnings extends StatefulWidget{

  Match match;

  StartInnings({Key key, @required this.match}) : super (key : key);

  _StartInnings createState() => _StartInnings(match: match);

}


class _StartInnings extends State<StartInnings> {
  Match match;

  _StartInnings({this.match});

  @override
  void initState() {



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
        title: Text("Toss"),
        flexibleSpace: getAppBarGradient(),
      ),

      body: Center(
        child: Center(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Text("Striker"),
//              DropdownButton(
//                value: _tossWonteam,
//                items: _dropdownteams,
//                onChanged: onChangedDropDownItem,
//              ),
//              SizedBox(height: _height * 0.05),
//              Text("Selected team : "+_tossWonteam.getTeamName()),
//
//              SizedBox(height: _height * 0.05),
//
//              Text("Selected to Option for innings"),
//              SizedBox(height: _height * 0.05),
//              DropdownButton<String>(
//                items: _inningsOptions.map((String dropDownSelectedIttem) {
//                  return DropdownMenuItem<String>(
//                    value: dropDownSelectedIttem,
//                    child: Text(dropDownSelectedIttem),
//                  );
//                }).toList(),
//
//                onChanged: (String newValueSelected){
//                  setState(() {
//                    this._optionSelected = newValueSelected;
//                  });
//                },
//                value: _optionSelected,
//              ),
//            ],
//          ),
        ),

      ),
    );

  }
}