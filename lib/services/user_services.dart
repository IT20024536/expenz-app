import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService{

  static Future<void> storeUserDetails(
  {
    required String userName,
    required String email,
    required String password,
    required String conformPassword,
    required BuildContext context})async{

    try{

      if(password != conformPassword){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Password and Conform Password did not match")
            )
        );
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("username", userName);
      await prefs.setString("email", email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("User Details Stored Successfully")
        )
      );

    }catch(err){
      err.toString();
    }
  }

  static Future<bool> checkUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('username');
    return userName != null;
  }

}