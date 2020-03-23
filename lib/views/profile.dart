import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/widgets/cupertinoDatePick.dart';
import 'package:flutter_app/widgets/provider_widget.dart';
import 'package:intl/intl.dart';

class Profile extends StatelessWidget{

  DateTime _dateTime = new DateTime.now();
  int _phoneNumber; String _name;
  String _place;
  dynamic user;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
        child : new Container(
            child: new Column(
              children: <Widget>[
                
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CircleAvatar(
                    backgroundImage: ExactAssetImage("lib/assets/images/default_profile_avatar.png"),
                    backgroundColor: Colors.transparent,
                    minRadius: 30,
                    maxRadius: 60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    child: Column(
                      children: buildInputs(context),
                    ),
                  ),
                )
              ],
          ),
        )
    );
  }

  List<Widget> buildInputs(BuildContext context){
    List<Widget> textFields = [];
    textFields.add(
      TextFormField(

        decoration: InputDecoration(
            labelText: 'Name'
        ),
        style: TextStyle(fontSize: 15.0),
        onChanged: (value) => _name = (user.name == null) ? (value) : user.name,
      ),
    );
    print(_name);
    textFields.add(SizedBox(height: 10));

    textFields.add(
      TextFormField(
        decoration: InputDecoration(
            labelText: 'location'
        ),
        style: TextStyle(fontSize: 15.0),
        onChanged: (value) => _place = value,
      ),
    );
    print(_place);
    textFields.add(SizedBox(height: 10));

    textFields.add(
      TextFormField(
          decoration: InputDecoration(
            labelText: 'Phone Number'
        ),
          keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 15.0),
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        onChanged: (value) => _phoneNumber = value as int,
      ),
    );
    print(_phoneNumber);
    textFields.add(SizedBox(height: 10));

    textFields.add(
      TextFormField(
        decoration: InputDecoration(
            labelText: 'Phone Number'
        ),
        onTap: () {
          showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) {
              return BuildBottomDatePicker(
                CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: new DateTime(1947, 1, 1),
                  maximumDate: new DateTime.now(),
                  onDateTimeChanged: (DateTime newDateTime) {
                    print("Your Selected Date: ${newDateTime}");
                    _dateTime = newDateTime;
                  },
                ),
              );
            },
          );
        },
      ),
    );
    textFields.add(SizedBox(height: 10));

    return textFields;
  }

  getUserDetail(context){
    FutureBuilder(
      future: Provider.of(context).auth.getCurrentUID(),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          user = snapshot.data;
          print("snap shot : ${snapshot.data}");
          return snapshot.data;
        }
        print("snap shot : ${snapshot.data}");
        return null;
      },
    );
  }

}
