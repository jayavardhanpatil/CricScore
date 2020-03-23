import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/widgets/loader.dart';
import 'package:flutter_app/widgets/provider_widget.dart';


// TODO move this to tone location
final primaryColor = const Color(0xFF75A2EA);

enum AuthFormType { signIn, signUp }

class SignUpView extends StatefulWidget {
  final AuthFormType authFormType;

  SignUpView({Key key, @required this.authFormType}) : super(key: key);

  @override
  _SignUpViewState createState() =>
      _SignUpViewState(authFormType: this.authFormType);
}

class _SignUpViewState extends State<SignUpView> {
  AuthFormType authFormType;

  _SignUpViewState({this.authFormType});

  final formKey = GlobalKey<FormState>();
  bool loading = false;
  String _email, _password, _error;

  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == "signUp") {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }


  bool validate(){
    final form = formKey.currentState;
    form.save();
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void submit() async {
    if(validate()) {
      final form = formKey.currentState;
      form.save();
      try {
        final auth = Provider
            .of(context)
            .auth;
        setState(() => loading = true);
        if (authFormType == AuthFormType.signIn) {
          User user = await auth.signInWithEmailAndPassword(_email, _password);
          print("Signed In with ID "+user.email);
          //setState(() => loading = false);
          //Navigator.of(context).pushReplacementNamed('/home');
        } else {
          User user = await auth.createUserWithEmailAndPassword(
              _email, _password);
            print("Signed up with New ID " + user.email);
          //setState(() => loading = false);
          //Navigator.of(context).pushReplacementNamed('/home');
        }
      } catch (e) {
        print("Error : "+ e.toString());
        setState(() {
          _error = e.message;
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return loading ? Loading() : Scaffold(
      body: Container(
        color: primaryColor,
        height: _height,
        width: _width,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: _height * 0.05),
              showAlert(),
              SizedBox(height: _height * 0.05),
              buildHeaderText(),
              SizedBox(height: _height * 0.05),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: buildInputs() + buildButtons(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AutoSizeText buildHeaderText() {
    String _headerText;
    if (authFormType == AuthFormType.signUp) {
      _headerText = "Create New Account";
    } else {
      _headerText = "Sign In";
    }
    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 35,
        color: Colors.white,
      ),
    );
  }

  Widget showAlert(){
    if(_error != null){
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(child: AutoSizeText(_error, maxLines: 3,),),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: (){
                setState(() {
                  _error = null;
                });
              },
            )
          ],
        ),
      );
    }
    return SizedBox(height: 0);
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    // if were in the sign up state add name
   /* if (authFormType == AuthFormType.signUp) {
      textFields.add(
        TextFormField(
          style: TextStyle(fontSize: 22.0),
          decoration: buildSignUpInputDecoration("Name"),
          onChanged: (value) => _name = value,
        ),
      );
      textFields.add(SizedBox(height: 20));
    }*/

    // add email & password
    textFields.add(
      TextFormField(
        validator: Validator.validate,
        style: TextStyle(fontSize: 22.0),
        decoration: buildSignUpInputDecoration("Email"),
        onChanged: (value) => _email = value,
      ),
    );
    textFields.add(SizedBox(height: 20));
    textFields.add(
      TextFormField(
        validator: Validator.validate,
        style: TextStyle(fontSize: 22.0),
        decoration: buildSignUpInputDecoration("Password"),
        obscureText: true,
        onChanged: (value) => _password = value,
      ),
    );
    textFields.add(SizedBox(height: 20));

    return textFields;
  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0)),
      contentPadding:
          const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
    );
  }

  List<Widget> buildButtons() {
    String _switchButtonText, _newFormState, _submitButtonText;

    if (authFormType == AuthFormType.signIn) {
      _switchButtonText = "Create New Account";
      _newFormState = "signUp";
      _submitButtonText = "Sign In";
    } else {
      _switchButtonText = "Have an Account? Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Sign Up";
    }

    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.white,
            textColor: primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _submitButtonText,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
              ),
            ),
            onPressed: submit,
        ),
      ),
      FlatButton(
        child: Text(
          _switchButtonText,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          switchFormState(_newFormState);
        },
      )
    ];
  }
}
