
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/innings.dart';
import 'package:flutter_app/model/match.dart';
import 'package:flutter_app/model/player.dart';
import 'package:flutter_app/model/team.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/widgets/ToastWidget.dart';
import 'package:flutter_app/widgets/gradient.dart';

class StartInnings extends StatefulWidget{

  MatchGame match;

  StartInnings({Key key, @required this.match}) : super (key : key);

  _StartInnings createState() => _StartInnings(match: match);

}


class _StartInnings extends State<StartInnings> {
  MatchGame match;

  _StartInnings({this.match});

  List<Player> battingPlayers = List();
  List<Player> bowlingPlayers = List();
  List<DropdownMenuItem<Player>> _dropdownMenuItemsForBatting;
  List<DropdownMenuItem<Player>> _dropdownMenuItemsForBowling;
  Map<String, Player> batmans;
  Map<String, Player> bowlers;


  @override
  void initState() {
    buildDropdownMenuItemsForBatting();
    buildDropdownMenuItemsForBowling();
    super.initState();
  }

  List<DropdownMenuItem<Player>> buildDropdownMenuItemsForBatting(){
    List<DropdownMenuItem<Player>> items = List();

    if(!match.getisFirstInningsOver()){
      match.firstInning.battingTeam.forEach((key, value) {
        battingPlayers.add(value);
        items.add(DropdownMenuItem(
          value: value,
          child: Text(value.playerName),
        ));
      });
    }else{
      match.secondInning.battingTeam.forEach((key, value) {
        items.add(DropdownMenuItem(
          value: value,
          child: Text(value.playerName),
        ));
      });
    }
    return items;
  }

  List<DropdownMenuItem<Player>> buildDropdownMenuItemsForBowling(){
    List<DropdownMenuItem<Player>> items = List();

    if(!match.getisFirstInningsOver()){
      match.firstInning.bowlingTeam.forEach((key, value) {
        bowlingPlayers.add(value);
        items.add(DropdownMenuItem(
          value: value,
          child: Text(value.playerName),
        ));
      });
    }else{
      match.secondInning.bowlingTeam.forEach((key, value) {
        items.add(DropdownMenuItem(
          value: value,
          child: Text(value.playerName),
        ));
      });
    }
    return items;
  }

  DirectSelectItem<Player> getDropDownMenuItem(Player value) {
    return DirectSelectItem<Player>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Text(value.playerName);
        });
  }

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
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

    batmans = new Map();
    bowlers = new Map();

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Openers"),
        flexibleSpace: getAppBarGradient(),
      ),
      body: DirectSelectContainer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SizedBox(height: _height * 0.06),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      margin: EdgeInsets.only(left: 4),
                      child: Text("Select Opener, Striker Batsman!", style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                                    child: DirectSelectList<Player>(
                                        values: battingPlayers,
                                        defaultItemIndex: 0,
                                        itemBuilder: (Player value) => getDropDownMenuItem(value),
                                        focusedItemDecoration: _getDslDecoration(),
                                        onItemSelectedListener: (item, index, context) {
                                          item.isOnStrike = true;
                                          batmans.update("strker", (value) => item, ifAbsent: () => item);
                                          //Scaffold.of(context).showSnackBar(SnackBar(content: Text(item.playerName)));
                                        }),
                                    padding: EdgeInsets.only(left: 12))),
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.unfold_more,
                                color: Color(0xFF6190E8),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: _height * 0.06),

                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      margin: EdgeInsets.only(left: 4),
                      child: Text("Select Non-Striker Batsman!", style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                                    child: DirectSelectList<Player>(
                                        values: battingPlayers,
                                        defaultItemIndex: 0,
                                        itemBuilder: (Player value) => getDropDownMenuItem(value),
                                        focusedItemDecoration: _getDslDecoration(),
                                        onItemSelectedListener: (item, index, context) {
                                          batmans.update("nonstrker", (value) => item, ifAbsent: () => item);
                                          //Scaffold.of(context).showSnackBar(SnackBar(content: Text(item.playerName)));
                                        }),
                                    padding: EdgeInsets.only(left: 12))),
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.unfold_more,
                                color: Color(0xFF6190E8),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),


                    SizedBox(height: _height * 0.06),

                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      margin: EdgeInsets.only(left: 4),
                      child: Text("Select Opener Bowler!", style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15) ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                                    child: DirectSelectList<Player>(
                                        values: bowlingPlayers,
                                        defaultItemIndex: 0,
                                        itemBuilder: (Player value) => getDropDownMenuItem(value),
                                        focusedItemDecoration: _getDslDecoration(),
                                        onItemSelectedListener: (item, index, context) {
                                          bowlers.update("opene_bowler", (value) => item, ifAbsent: () => item);
                                          //Scaffold.of(context).showSnackBar(SnackBar(content: Text(item.playerName)));
                                        }),
                                    padding: EdgeInsets.only(left: 12))),
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.unfold_more,
                                color: Color(0xFF6190E8),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: _height * 0.1),

                    RaisedButton(
                      onPressed: () {

                        if(batmans.length != 2){
                          showFailedColoredToast("Please select two Batsmans!");
                        }
                        else if(bowlers.length != 1){
                          showFailedColoredToast("Please select One Bowler!");
                        }else {
                          Map<String, Player> batsmans = new Map();
                          batmans.forEach((key, value) {
                            batsmans.putIfAbsent(value.playerUID, () => value);
                          });

                          Map<String, Player> bowler = new Map();
                          bowler.putIfAbsent(bowlers["opene_bowler"]
                              .playerUID, () => bowlers["opene_bowler"]);

                          Inning currentInning = new Inning(
                              battingTeam: batsmans, bowlingTeam: bowler);
                          currentInning.run = 0;
                          currentInning.wickets = 0;
                          currentInning.extra = 0;
                          currentInning.overs = 0;
                          match.currentPlayers = currentInning;

                          DatabaseService().addMatch(match);

                        }
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        width: _width * 0.8,
                        decoration: getButtonGradientColor(BoxShape.rectangle),
                        padding: const EdgeInsets.all(10.0),
                        child: const Text(
                            'Start Match',
                            style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              

//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Column(
//                  children: <Widget>[
//                    Container(
//                      alignment: AlignmentDirectional.centerStart,
//                      margin: EdgeInsets.only(left: 4),
//                      child: Text("City"),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
//                      child: Card(
//                        child: Row(
//                          mainAxisSize: MainAxisSize.max,
//                          children: <Widget>[
//                            Expanded(
//                                child: Padding(
//                                    child: DirectSelectList<Player>(
//                                        values: battingPlayers,
//                                        defaultItemIndex: -1,
//                                        itemBuilder: (Player value) => getDropDownMenuItem(value),
//                                        focusedItemDecoration: _getDslDecoration(),
//                                        onItemSelectedListener: (item, index, context) {
//                                          Scaffold.of(context).showSnackBar(SnackBar(content: Text(item.playerName)));
//                                        }),
//                                    padding: EdgeInsets.only(left: 12))),
//                            Padding(
//                              padding: EdgeInsets.only(right: 8),
//                              child: Icon(
//                                Icons.unfold_more,
//                                color: Colors.black38,
//                              ),
//                            )
//                          ],
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
            ],
          ),
        ),













//        child: Center(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Text("Striker"),
//              DropdownButton(
//                value: _selectedStrikerPlayer,
//                items: _dropdownMenuItemsForBatting,
//                onChanged: onChangedStrikerBattingDropDownItem,
//              ),
//              SizedBox(height: _height * 0.05),
//              Text(_selectedStrikerPlayer.playerName),
//
//              SizedBox(height: _height * 0.05),
//
//              SizedBox(height: _height * 0.05),
//
//              Text("Non Striker : "),
//              DropdownButton(
//                value: _selectedNonStrikerPlayer,
//                items: _dropdownMenuItemsForBatting,
//                onChanged: onChangedNonBattingDropDownItem,
//              ),
//              SizedBox(height: _height * 0.05),
//              Text(_selectedNonStrikerPlayer.playerName),
//
//              SizedBox(height: _height * 0.05),
//
//              SizedBox(height: _height * 0.05),
//
//
//              Text("Bowler"),
//              DropdownButton(
//                value: _selectedBowlerPlayer,
//                items: _dropdownMenuItemsForBowling,
//                onChanged: onChangedBowlingDropDownItem,
//              ),
//              SizedBox(height: _height * 0.05),
//              Text(_selectedBowlerPlayer.playerName),
//
//              SizedBox(height: _height * 0.05),
//
//
////              DropdownButton<String>(
////                items: _inningsOptions.map((String dropDownSelectedIttem) {
////                  return DropdownMenuItem<String>(
////                    value: dropDownSelectedIttem,
////                    child: Text(dropDownSelectedIttem),
////                  );
////                }).toList(),
////
////                onChanged: (String newValueSelected){
////                  setState(() {
////                    this._optionSelected = newValueSelected;
////                  });
////                },
////                value: _optionSelected,
////              ),
//            ],
//          ),
//        ),

      ),
    );

  }
}