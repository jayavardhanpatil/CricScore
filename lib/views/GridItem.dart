import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';


class GridItem extends StatefulWidget {
  final Key key;
  final User item;
  final ValueChanged<bool> isSelected;

  GridItem({this.item, this.isSelected, this.key});

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.isSelected(isSelected);
        });
      },
      child: Stack(
        children: <Widget>[
          Image.asset(
            "lib/assets/images/default_profile_avatar.png",
            color: Colors.black.withOpacity(isSelected ? 0.9 : 0),
            colorBlendMode: BlendMode.color,
          ),
          isSelected
              ? Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue,
              ),
            ),
          )
              : Container()
        ],
      ),
    );
  }
}