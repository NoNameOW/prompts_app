import 'package:flutter/material.dart';
import 'package:prompt_app/models/user.dart';
import 'package:prompt_app/services/auth.dart';
import 'package:prompt_app/services/database.dart';
import 'package:prompt_app/shared/prompts/pageprompt.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(
           onPressed: () async {
             await _auth.signOut();
           },
           icon: Icon(Icons.lock),
           label: Text('Sign Out')
           )
        ],
        title: Text('Prompts'),
        backgroundColor: Colors.indigo[800],
      ),
      backgroundColor: Colors.lightBlue[100],
      body: PromptPage(),
    );
  }
}