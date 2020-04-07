import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: SpinKitDoubleBounce(
              color: Color(0xFF75A2EA),
              size: 70,
            ),
          )
      ),
    );
  }
}