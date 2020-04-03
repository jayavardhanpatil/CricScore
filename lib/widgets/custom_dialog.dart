//import 'package:direct_select_flutter/direct_select_list.dart';
//import 'package:flutter/material.dart';
//import 'package:auto_size_text/auto_size_text.dart';
//import 'package:flutter_app/model/match.dart';
//import 'package:flutter_app/model/player.dart';
//
//class CustomDialog extends StatelessWidget {
//
//  final String title,
//      description,
//      primaryButtonText,
//      primaryButtonRoute,
//      secondaryButtonText,
//      secondaryButtonRoute;
//
//  CustomDialog(
//      {@required this.title,
//      @required this.description,
//      @required this.primaryButtonText,
//      @required this.primaryButtonRoute,
//      this.secondaryButtonText,
//      this.secondaryButtonRoute});
//
//  static const double padding = 20.0;
//
//  @override
//  Widget build(BuildContext context) {
//    return Dialog(
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(padding),
//      ),
//      child: Stack(
//        children: <Widget>[
//
//          Container(
//            alignment: AlignmentDirectional.centerStart,
//            margin: EdgeInsets.only(left: 4),
//            child: Text("Select Opener Bowler!", style: TextStyle(
//                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15) ),
//          ),
//          Padding(
//            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
//            child: Card(
//              child: Row(
//                mainAxisSize: MainAxisSize.max,
//                children: <Widget>[
//                  Expanded(
//                      child: Padding(
//                          child: DirectSelectList<Player>(
//                              values: bowlingPlayers,
//                              itemBuilder: (Player value) => getDropDownMenuItem(value),
//                              focusedItemDecoration: _getDslDecoration(),
//                              onItemSelectedListener: (item, index, context) {
//                                bowlers.update("open_bowler", (value) => item, ifAbsent: () => item);
//                                //Scaffold.of(context).showSnackBar(SnackBar(content: Text(item.playerName)));
//                              }),
//                          padding: EdgeInsets.only(left: 12))),
//                  Padding(
//                    padding: EdgeInsets.only(right: 8),
//                    child: Icon(
//                      Icons.unfold_more,
//                      color: Color(0xFF6190E8),
//                    ),
//                  )
//                ],
//              ),
//            ),
//          ),
//
//
////          Container(
////            padding: EdgeInsets.all(padding),
////            decoration: BoxDecoration(
////                color: Colors.white,
////                shape: BoxShape.rectangle,
////                borderRadius: BorderRadius.circular(padding),
////                boxShadow: [
////                  BoxShadow(
////                    color: Colors.black,
////                    blurRadius: 10.0,
////                    offset: const Offset(0.0, 10.0),
////                  ),
////                ]),
////            child: Column(
////              mainAxisSize: MainAxisSize.min,
////              children: <Widget>[
////                SizedBox(height: 24.0),
////                AutoSizeText(
////                  title,
////                  maxLines: 2,
////                  textAlign: TextAlign.center,
////                  style: TextStyle(
////                    color: primaryColor,
////                    fontSize: 25.0,
////                  ),
////                ),
////                SizedBox(height: 24.0),
////                AutoSizeText(
////                  description,
////                  maxLines: 4,
////                  textAlign: TextAlign.center,
////                  style: TextStyle(
////                    color: grayColor,
////                    fontSize: 18.0,
////                  ),
////                ),
////                SizedBox(height: 24.0),
////                RaisedButton(
////                  color: primaryColor,
////                  shape: RoundedRectangleBorder(
////                      borderRadius: BorderRadius.circular(30.0)),
////                  child: Padding(
////                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
////                    child: AutoSizeText(
////                      primaryButtonText,
////                      maxLines: 1,
////                      style: TextStyle(
////                        fontSize: 18,
////                        fontWeight: FontWeight.w200,
////                        color: Colors.white,
////                      ),
////                    ),
////                  ),
////                  onPressed: () {
////                    Navigator.of(context).pop();
////                    Navigator.of(context)
////                        .pushReplacementNamed(primaryButtonRoute);
////                  },
////                ),
////                SizedBox(height: 10.0),
////                showSecondaryButton(context),
////              ],
////            ),
////          )
//        ],
//      ),
//    );
//  }
//
//  showSecondaryButton(BuildContext context) {
//    if (secondaryButtonRoute != null && secondaryButtonText != null ){
//      return FlatButton(
//        child: AutoSizeText(
//          secondaryButtonText,
//          maxLines: 1,
//          style: TextStyle(
//            fontSize: 18,
//            color: primaryColor,
//            fontWeight: FontWeight.w400,
//          ),
//        ),
//        onPressed: () {
//          Navigator.of(context).pop();
//          Navigator.of(context).pushReplacementNamed(secondaryButtonRoute);
//        },
//      );
//    } else {
//      return SizedBox(height: 10.0);
//    }
//  }
//
//
//  void _showDialog(context) {
//    // flutter defined function
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return alert dialog object
//        return AlertDialog(
//          title: new Text('I am Title'),
//          content: Container(
//            height: 150.0,
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
//              children: <Widget>[
//                new Row(
//                  children: <Widget>[
//                    new Icon(Icons.toys),
//                    Padding(
//                      padding: const EdgeInsets.only(left: 8.0),
//                      child: new Text(' First Item'),
//                    ),
//                  ],
//                ),
//                new SizedBox(
//                  height: 20.0,
//                ),
//                new Row(
//                  children: <Widget>[
//                    new Icon(Icons.toys),
//                    Padding(
//                      padding: const EdgeInsets.only(left: 8.0),
//                      child: new Text(' Second Item'),
//                    ),
//                  ],
//                ),
//                new SizedBox(
//                  height: 20.0,
//                ),
//                new Row(
//                  children: <Widget>[
//                    new Icon(Icons.toys),
//                    Padding(
//                      padding: const EdgeInsets.only(left: 8.0),
//                      child: new Text('Third Item'),
//                    ),
//                  ],
//                ),
//              ],
//            ),
//          ),
//        );
//      },
//    );
//  }
//
//}
