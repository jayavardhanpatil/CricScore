import 'package:direct_select/direct_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/match.dart';
import 'package:flutter_app/model/player.dart';

class MyHomePage_select extends StatefulWidget {
  MatchGame match;

  MyHomePage_select({Key key, this.match}) : super(key: key);

  @override
  _MyHomePage_selectState createState() => _MyHomePage_selectState(match: match);
}

class _MyHomePage_selectState extends State<MyHomePage_select> {

  MatchGame match;

  _MyHomePage_selectState({this.match});

  List<Player> battingPlayers = List();
  List<Player> bowlingPlayers = List();
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
      match.firstInning.battingteam.players.forEach((key, value) {
        battingPlayers.add(value);
        items.add(DropdownMenuItem(
          value: value,
          child: Text(value.playerName),
        ));
      });
    }else{
      match.secondInning.battingteam.players.forEach((key, value) {
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
      match.firstInning.bowlingteam.players.forEach((key, value) {
        bowlingPlayers.add(value);
        items.add(DropdownMenuItem(
          value: value,
          child: Text(value.playerName),
        ));
      });
    }else{
      match.secondInning.bowlingteam.players.forEach((key, value) {
        items.add(DropdownMenuItem(
          value: value,
          child: Text(value.playerName),
        ));
      });
    }
    return items;
  }

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }

  int selectedIndex1 = 0,
      selectedIndex2 = 0,
      selectedIndex3 = 0,
      selectedIndex4 = 0;

  List<Widget> _buildItems1() {
    return battingPlayers
        .map((val) => MySelectionItem(
      title: val.playerName,
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "To which meal?",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                DirectSelect(
                    itemExtent: 60.0,
                    selectedIndex: selectedIndex1,
                    child: MySelectionItem(
                      isForList: false,
                      title: battingPlayers[selectedIndex1].playerName,
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndex1 = index;
                      });
                    },
                    items: _buildItems1()),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    "Search our database by name",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

//You can use any Widget
class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
        child: _buildItem(context),
        padding: EdgeInsets.all(10.0),
      )
          : Card(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          children: <Widget>[
            _buildItem(context),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_drop_down),
            )
          ],
        ),
      ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(title),
    );
  }
}