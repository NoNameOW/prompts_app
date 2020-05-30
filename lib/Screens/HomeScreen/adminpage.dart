import 'package:flutter/material.dart';
import 'package:prompt_app/models/user.dart';
import 'package:prompt_app/services/auth.dart';
import 'package:prompt_app/services/database.dart';
import 'package:prompt_app/shared/textinputdecor.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final AuthService _auth = AuthService();

  final DataBaseService _database = DataBaseService();

  final _formKey = GlobalKey<FormState>();

  String title = '';
  String text = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        title: 
        Text('Create a new prompt'),
         actions: <Widget>[
          FlatButton.icon(
           onPressed: () async {
             await _auth.signOut();
           },
           icon: Icon(Icons.lock),
           label: Text('Sign Out')
           )
        ],
        
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (val) => val.isEmpty? 'Enter an Title': null,
                onChanged: (val) {
                  setState(() => title = val);
                },
                decoration: textInputDecor.copyWith(hintText : 'Title'),
              ),
              TextFormField(
                validator: (val) => val.isEmpty? 'Enter some Text': null,
                onChanged: (val) {
                  setState(() => text = val);
                },
                decoration: textInputDecor.copyWith(hintText : 'Text'),
              ),
              FlatButton(
              onPressed: () async {
                if (_formKey.currentState.validate()){
                  dynamic result = await _database.newPrompt(text, title);
                  if (result == null){
                    setState(() => error = 'Failed to submit response. try again');
                  } else {
                    setState(() => error = 'prompt submitted');
                  }
                }
              },
              child: Text('SUBMIT'),
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