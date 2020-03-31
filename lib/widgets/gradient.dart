
import 'package:flutter/cupertino.dart';

getButtonGradientColor(BoxShape shape){
   return BoxDecoration(
     shape: shape,
     gradient: LinearGradient(
       colors: <Color>[
//         Color(0xFF42A5F5),
//         Color(0xFF1976D2),
//         Color(0xFF0D47A1),
         Color(0xFF0D47A1),
         Color(0xFF42A5F5),
         Color(0xFF0D47A1),
       ],
     ),
   );
}