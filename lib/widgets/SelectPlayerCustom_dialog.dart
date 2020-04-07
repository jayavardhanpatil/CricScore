
import 'package:direct_select/direct_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/player.dart';
import 'package:flutter_app/widgets/gradient.dart';

class selectPlayerDialog extends StatefulWidget {

  List<Player> playerList;

  selectPlayerDialog({Key key, @required this.playerList}) : super (key: key);

  _selectPlayerDialog createState() => _selectPlayerDialog(playerList: playerList);
}

class _selectPlayerDialog extends State<selectPlayerDialog>{
  int selectedIndex1 = 0;
  List<Player> playerList;

  _selectPlayerDialog({this.playerList});


  List<Widget> _buildItems1() {
    return playerList
        .map((val) => MySelectionItem(
      title: val.playerName,
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
    height: 300,
    decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10)
    ),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              "Select next batsman", textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),

          SizedBox(height: 50,),

          DirectSelect(
              itemExtent: 60.0,
              selectedIndex: selectedIndex1,
              child: MySelectionItem(
                isForList: false,
                title: playerList[selectedIndex1].playerName,
              ),
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedIndex1 = index;
                });
              },
              items: _buildItems1()),

          SizedBox(height: 50,),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: (){
                    Navigator.pop(context, playerList[selectedIndex1]);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    //decoration: getButtonGradientColor(RoundedRectangleBorder),
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                        'cancel',
                        style: TextStyle(fontSize: 20)
                    ),
                  ),
                ),
              ),


              SizedBox(width: 20,),


              Container(
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: (){
                    Navigator.pop(context, playerList[selectedIndex1]);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    decoration: getButtonGradientColor(BoxShape.rectangle),
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                        'Confirm',
                        style: TextStyle(fontSize: 20)
                    ),
                  ),
                ),
              )

            ],
          )
        ]),
  );
}

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