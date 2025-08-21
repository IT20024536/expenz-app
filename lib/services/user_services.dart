import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService{

  ///Store the userName and password using shared preferences
  static Future<void> storeUserDetails(
  {
    required String userName,
    required String email,
    required String password,
    required String conformPassword,
    required BuildContext context})async{

    try{

      ///check if the password and confirm password are the same
      if(password != conformPassword){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Password and Conform Password did not match")
            )
        );
      }

      ///Store the username and email in shared preferences
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

  ///check if the username is stored in shared preferences
  static Future<bool> checkUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('username');
    return userName != null;
  }

  ///get the username and email
  static Future<Map<String, String>> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userName = pref.getString("username");
    String? email = pref.getString("email");
    return {"username": userName!, "email": email!};
  }

  ///remove the username and email from shared preference
  static Future<void> clearUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('username');
    await pref.remove('email');
  }

}