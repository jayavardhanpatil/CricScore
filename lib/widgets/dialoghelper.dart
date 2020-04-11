
import 'package:flutter/material.dart';
import 'package:CricScore/model/player.dart';

import 'SelectPlayerCustom_dialog.dart';

class DialogHelper{

  static exit(context) => showDialog(context: context, builder: (context) => selectPlayerDialog());

}