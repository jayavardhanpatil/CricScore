import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  void validateAndSubmit() async{
    print(emailController.toString());
    print(_password.toString());
   AuthResult result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.toString(), password: _password.toString());
   try {
     print(result.user.email);
   }catch(e){
     print("Some thimg went wrong");
   }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LogIn Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller : emailController,
                decoration: InputDecoration(labelText: 'Email',),
              ),
              TextField(
                obscureText: true,
                controller : _password,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              RaisedButton(
                child: Text('Login', style: TextStyle(fontSize: 20),),
                onPressed: validateAndSubmit,
              )
            ],
          ),
        ),
      ),
    );
  }
}
