
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/database_service.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

Widget typeAhed(TextEditingController typedValue,  TextEditingController valueController, double width, String lable){
  return Container(
    width: width,
    child: TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: typedValue,
        decoration: InputDecoration(
          labelText: lable
        ),
        style: TextStyle(fontFamily: "Lemonada",)
      ),
      suggestionsCallback: (pattern) {
        // ignore: missing_return
        if(pattern.length > 2) {
          return DatabaseService().getCity(pattern[0].toUpperCase()+pattern.substring(1));
        }
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion, style: TextStyle(fontFamily: "Lemonada",),),
        );
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (suggestion) {
        typedValue.text = suggestion;
        valueController.text = suggestion;
      },
    ),
  );
}