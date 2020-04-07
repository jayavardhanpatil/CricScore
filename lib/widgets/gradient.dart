
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

getButtonGradientColor(BoxShape shape){
   return BoxDecoration(
     shape: shape,
     borderRadius: (shape != BoxShape.circle) ? BorderRadius.circular(50) : null,
     gradient: LinearGradient(
       colors: <Color>[
         Color(0xFF6190E8),
         Color(0xFF1976D2),
         Color(0xFF6190E8),
//         Color(0xFF090979),
//         Color(0xFF42A5F5),
//         Color(0xFF090979),
       ],
       stops: <double>[
         0.0, 0.5, 1.0
       ]
     ),
   );
}

getAppBarGradient(){
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            //Color(0xFF020024),
            Color(0xFF6190E8),
            Color(0xFF1976D2),
            Color(0xFF6190E8),
            //Color(0xFF020024),
          ]),
    ),
  );
}