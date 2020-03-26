
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_app/widgets/loader.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


class EditProfile extends StatefulWidget {
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {

  bool loading = true;
  final _phoneNumber = TextEditingController(text: AuthService.user.getPhoneNumber().toString());
  final _name = TextEditingController(text: AuthService.user.getName());
  final _city = TextEditingController(text: AuthService.user.getCity());
  final DateFormat format = DateFormat('yyyy-MM-dd');
  final _dateTime = TextEditingController(text: AuthService.user.getDateOfBirth());

  dynamic user;

  final TextEditingController _typeAheadController = TextEditingController(text: AuthService.user.getCity());

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    loading = false;

    return loading ? Loading() : Scaffold(
//        appBar: new AppBar(
//          title: Text(AppBarsTitles.EDIT_PROFILE_APP_BAR_TITLE),
//        ),
        body: EditProfileBody(context),
    );
  }


  Widget EditProfileBody(BuildContext context){
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
                  print(_dateTime.text.toString());

                  DatabaseService.cities.clear();
                  User user = AuthService.user;
                  DatabaseService().addUser(new User(uid: user.uid,
                      name: _name.text.toString(),
                      city: _city.text.toString(),
                      phoneNumber: int.parse(_phoneNumber.text),
                      dob: _dateTime.text.toString(),
                      email: user.email
                  ));
                  DatabaseService().reLoadUserRecord(AuthService.user.uid);
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
        controller: _dateTime,
        onChanged: (value){
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
