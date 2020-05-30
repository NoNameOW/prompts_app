import 'package:flutter/material.dart';
import 'package:prompt_app/services/auth.dart';
import 'package:prompt_app/shared/textinputdecor.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  //Text Feild State
  String email = '';
  String password = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
        title: Text('Sign in to prompts'),
        actions: <Widget>[
          FlatButton.icon(
           onPressed: () => widget.toggleView(),
           icon: Icon(Icons.lock),
           label: Text('Register')
           )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0,),
              TextFormField(
                decoration: textInputDecor.copyWith(hintText: 'email'),
                validator: (val) => val.isEmpty? 'Enter an Email': null,
                onChanged: (val) {
                  setState(() => email = val);
                },

              ),
              SizedBox(height: 30.0,),
              TextFormField(
                decoration: textInputDecor.copyWith(hintText: 'password'),
                validator: (val) => val.length < 6 ? 'Enter an Password longer than 6 characters': null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },

              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.limeAccent[700],
                child: Text('Sign In'),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null){
                      setState(() {
                        loading = false;
                        error = 'Could not sign in with the email and password you provided. Please try again';
                      });
                    }
                  }
                },
              ),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0

                )
              )
            ],
          ),

        ),

      ),
    );
  }
}