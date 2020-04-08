
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/model/appStaticBarTitles.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/widgets/gradient.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


enum ProfileBodyEnum { view, edit }

class EditProfile extends StatefulWidget {
  final ProfileBodyEnum profileBodyType;

  EditProfile({Key key, @required this.profileBodyType}) : super(key: key);

  @override
  _EditProfile createState() =>
      _EditProfile(profileBodyType: this.profileBodyType);
}

class _EditProfile extends State<EditProfile> {
  ProfileBodyEnum profileBodyType;

  _EditProfile({this.profileBodyType});

  bool loading = false;
  final _phoneNumber = TextEditingController(
      text: (AuthService.user.getPhoneNumber() == null) ? null : AuthService.user.getPhoneNumber().toString());
  final _name = TextEditingController(text: AuthService.user.getName());
  final _city = TextEditingController(text: AuthService.user.getCity());
  final DateFormat format = DateFormat('yyyy-MM-dd');
  final _dateTime = TextEditingController(
      text: AuthService.user.getDateOfBirth());
  final _typeAheadController = TextEditingController(
      text: AuthService.user.getCity());

  var _width;
  var _height;


  @override
  Widget build(BuildContext context) {

    _width = MediaQuery
        .of(context)
        .size
        .width;
    _height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      appBar: new AppBar(
        title: Text(AppBarsTitles.EDIT_PROFILE_APP_BAR_TITLE),
        flexibleSpace: getAppBarGradient(),
      ),

      body: (profileBodyType == ProfileBodyEnum.edit) ? ProfileBody(context, true) : ProfileView(context, false),
    );
  }

  Widget ProfileBody(BuildContext context, bool editable) {
    return SingleChildScrollView(
        child: new Container(
          child: new Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CircleAvatar(
                  backgroundImage: ExactAssetImage(
                      "lib/assets/images/default_profile_avatar.png"),
                  backgroundColor: Colors.transparent,
                  minRadius: 30,
                  maxRadius: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  child: Column(
                    children: buildInputs(context, editable),
                  ),
                ),
              ),


              SizedBox(height: _height * 0.05,),

              FlatButton(
                onPressed: () {

                  print(_phoneNumber.text.toString());
                  print(_name.text.toString());
                  print(_city.text.toString());
                  print(_dateTime.text.toString());
                  DatabaseService.cities.clear();
                  User user = AuthService.user;
                  print(user.uid);
                  DatabaseService().addUser(new User(uid: user.uid,
                      name: _name.text.toString(),
                      city: _city.text.toString(),
                      phoneNumber: int.parse(_phoneNumber.text),
                      dateOfBirth: _dateTime.text.toString(),
                      email: user.email
                  )).then((value) => {
                    print("Added User"),
                    showSuccessColoredToast("Success"),
                  }).catchError((e){
                    showFailedColoredToast("failed");
                  });

                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: getButtonGradientColor(BoxShape.rectangle),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                      'Save profile',
                      style: TextStyle(fontSize: 20)
                  ),
                ),
              ),

            ],

          ),
        )
    );
  }

  Widget ProfileView(BuildContext context, bool editable) {
    return SingleChildScrollView(
        child: new Container(
          child: new Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CircleAvatar(
                  backgroundImage: ExactAssetImage(
                      "lib/assets/images/default_profile_avatar.png"),
                  backgroundColor: Colors.transparent,
                  minRadius: 30,
                  maxRadius: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  child: Column(
                    children: _EditProfile().buildInputs(context, false),
                  ),
                ),
              ),

              SizedBox(height: _height * 0.04),

              FlatButton(
                onPressed: () {
                  setState(() {
                    profileBodyType = ProfileBodyEnum.edit;
                  });
                },
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: getButtonGradientColor(BoxShape.rectangle),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 20)
                  ),
                ),

              ),
            ],

          ),
        )
    );
  }

  void showSuccessColoredToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Color.fromRGBO(44, 213, 83, 0.4),
      textColor: Colors.black87,
      gravity: ToastGravity.CENTER,
    );
  }

  void showFailedColoredToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Color.fromRGBO(252, 26, 10, 0.4),
      textColor: Colors.black87,
      gravity: ToastGravity.CENTER,
    );
  }

  List<Widget> buildInputs(BuildContext context, bool enabled) {
    List<Widget> textFields = [];
    textFields.add(
      TextField(
        controller: _name,
        enabled: enabled,
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
          enabled: enabled,
          decoration: InputDecoration(
            labelText: 'city',
          ),
        ),
        suggestionsCallback: (pattern) {
          if(pattern.length > 2) {
            return DatabaseService().getCity(pattern[0].toUpperCase()+pattern.substring(1));
          }
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
//        validator: (value) {
//          if (value.isEmpty) {
//            return 'Please select a city';
//          }
//        },

        //onSaved: (value) => this._city = value,
      ),
    );

    textFields.add(SizedBox(height: 10));

    textFields.add(
      TextField(
        controller: _phoneNumber,
        enabled: enabled,
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
        enabled: enabled,
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
        controller: _dateTime,
        onChanged: (value) {
          setState(() {
            _dateTime.text = format.format(value);
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


