import 'package:flutter/material.dart';
import 'package:prompt_app/Screens/AuthScreen/Authenticate.dart';
import 'package:prompt_app/Screens/HomeScreen/adminpage.dart';
import 'package:prompt_app/Screens/HomeScreen/home.dart';
import 'package:prompt_app/models/user.dart';
import 'package:prompt_app/services/auth.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    
    

    if (user == null){
      return Authenticate();
  
    } else{
      addAdmin(user, 'DwX5MMgZDLd56hi2sYHp3RA0FL22');
      print(user.isAdmin);
      if (user.isAdmin) {
        return AdminPage();
      } else{
        return Home();
      }
    }
      
  }
}

