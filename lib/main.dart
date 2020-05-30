import 'package:flutter/material.dart';
import 'package:prompt_app/Screens/wrapper.dart';
import 'package:prompt_app/models/user.dart';
import 'package:prompt_app/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper()
      ),

    );
  }
}