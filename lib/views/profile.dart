
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/widgets/provider_widget.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


class EditProfile extends StatefulWidget {
  _EditProfile createState() => _EditProfile();

}

class _EditProfile extends State<EditProfile> {

  String _phoneNumber;
  String _name, _place;
  final DateFormat format = DateFormat('yyyy-MM-dd');
  DateTime _dateTime;
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
                ),
                RaisedButton(
                  child: Text("Save"),
                  onPressed: (){
                    print(_name.toString());
                    print(_dateTime.toString());
                    print(_place.toString());
                    print(_phoneNumber.toString());
                  },
                )
              ],
          ),
        )
    );
  }

  List<Widget> buildInputs(BuildContext context){
    List<Widget> textFields = [];
    textFields.add(
      TextField(
        decoration: InputDecoration(
            labelText: 'Name'
        ),
        style: TextStyle(fontSize: 15.0),
        onChanged: (value) => _name = value,
      ),
    );
    textFields.add(SizedBox(height: 10));

    textFields.add(
      TextField(
        decoration: InputDecoration(
            labelText: 'location'
        ),
        style: TextStyle(fontSize: 15.0),
        onChanged: (value) => _place = value,
      ),
    );
    textFields.add(SizedBox(height: 10));

    textFields.add(
      TextField(
        decoration: InputDecoration(
            labelText: 'Phone '
        ),
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 15.0),
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        onChanged: (value) => _phoneNumber = value,
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

    print("Date : "+_dateTime.toString());

    textFields.add(SizedBox(height: 10));

    print(_name.toString());
    print(_phoneNumber.toString());
    print(_dateTime.toString());
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

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        decoration: InputDecoration(
          labelText: 'Date',

        ),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}
