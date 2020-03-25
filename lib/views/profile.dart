
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/widgets/loader.dart';
import 'package:flutter_app/widgets/provider_widget.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


class EditProfile extends StatefulWidget {
  _EditProfile createState() => _EditProfile();

}

class _EditProfile extends State<EditProfile> {

  final _phoneNumber = TextEditingController();
  final _name = TextEditingController();
  final _city = TextEditingController();
  final DateFormat format = DateFormat('yyyy-MM-dd');
  DateTime _dateTime = new DateTime.now();

  dynamic user;

  final TextEditingController _typeAheadController = TextEditingController();

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
                ),
                RaisedButton(
                  child: Text("Save"),
                  onPressed: (){


                    print(_phoneNumber.text.toString());
                    print(_name.text.toString());
                    print(_city.text.toString());
                    print(_dateTime);

                    DatabaseService.cities.clear();

                    User user = AuthService.user;
                    DatabaseService().addUser(new User(uid: user.uid,
                      name: _name.text.toString(),
                      city: _city.text.toString(),
                      phoneNumber: int.parse(_phoneNumber.text),
                      dob: _dateTime.toIso8601String(),
                      email: user.email
                    ));
                  },
                ),

              ],

          ),
        )
    );
  }

  List<Widget> buildInputs(BuildContext context){
    List<Widget> textFields = [];
    textFields.add(
      TextField(
        controller: _name,
        decoration: InputDecoration(
            labelText: 'Name'
        ),
        style: TextStyle(fontSize: 15.0),
        //onChanged: (value) => _phoneNumber = value,
      ),
    );
    textFields.add(SizedBox(height: 10));

    textFields.add(
      TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
            controller: this._typeAheadController,
            decoration: InputDecoration(
                labelText: 'city',
            ),
        ),
        suggestionsCallback: (pattern) {
          return DatabaseService().getCity(pattern);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        onSuggestionSelected: (suggestion) {
          this._typeAheadController.text = suggestion;
          this._city.text = suggestion;
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please select a city';
          }
        },

        //onSaved: (value) => this._city = value,
      ),
    );

    textFields.add(SizedBox(height: 10));

    textFields.add(
      TextField(
        controller: _phoneNumber,
        decoration: InputDecoration(
            labelText: 'Phone '
        ),
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 15.0),
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        //onChanged: (value) => _phoneNumber,
      ),
    );
    textFields.add(SizedBox(height: 10));

    textFields.add(
      DateTimeField(
        format: format,
        decoration: InputDecoration(
          labelText: 'Date',

        ),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1950),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime.now());
        },
        onChanged: (value){
          setState(() {
            _dateTime = value;
          });
        },
      ),
    );

    textFields.add(SizedBox(height: 10));

//    print(_name.toString());
//    print(_phoneNumber.toString());
//    print(_dateTime.toString());
    return textFields;
  }
}

//class BasicDateField extends StatelessWidget {
//  final format = DateFormat("yyyy-MM-dd");
//  @override
//  Widget build(BuildContext context) {
//    return Column(children: <Widget>[
//      DateTimeField(
//        format: format,
//        decoration: InputDecoration(
//          labelText: 'Date',
//
//        ),
//        onShowPicker: (context, currentValue) {
//          return showDatePicker(
//              context: context,
//              firstDate: DateTime(1900),
//              initialDate: currentValue ?? DateTime.now(),
//              lastDate: DateTime(2100));
//        },
//      ),
//    ]);
//  }
//}
