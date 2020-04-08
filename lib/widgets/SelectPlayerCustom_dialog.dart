

import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/player.dart';
import 'package:flutter_app/widgets/gradient.dart';

class selectPlayerDialog extends StatefulWidget {

  List<Player> playerList;
  String playerType;

  selectPlayerDialog({Key key, @required this.playerList, @required this.playerType}) : super (key: key);

  _selectPlayerDialog createState() => _selectPlayerDialog(playerList: playerList, playerType: playerType);
}

class _selectPlayerDialog extends State<selectPlayerDialog>{
  int selectedIndex1 = 0;
  List<Player> playerList;
  String playerType;
  Player selectedPlayer;

  _selectPlayerDialog({this.playerList, this.playerType});


  void initState(){
    selectedPlayer = playerList[0];
    super.initState();
  }

  DirectSelectItem<Player> getDropDownMenuItem(Player value) {
    return DirectSelectItem<Player>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Text(value.playerName, textAlign: TextAlign.center,);
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
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
        child : _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => DirectSelectContainer(
    decortion: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    child: Container(
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
              "Select next "+ playerType, textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),

          SizedBox(height: 50,),


            Container(
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                            child: DirectSelectList<Player>(
                                values: playerList,
                                itemBuilder: (Player value) => getDropDownMenuItem(value),
                                focusedItemDecoration: _getDslDecoration(),
                                defaultItemIndex: 0,
                                onItemSelectedListener: (item, index, context) {
                                  setState(() {
                                    selectedIndex1 = index;
                                  });
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

          SizedBox(height: 50,),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: (){
                    Navigator.pop(context, null);
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
    ),
  );
}