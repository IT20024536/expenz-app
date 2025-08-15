import 'dart:convert';

import 'package:expenz/models/expenz_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenzServices{

  ///expenz list
  List<Expenz> expenzList = [];

  ///define the key for storing expenses in shared pref
  static const String _expenzKey = 'expenz';

  ///save the expenz to shared pref
  Future<void> saveExpenzes(Expenz expenz, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenzes = prefs.getStringList(_expenzKey);

      ///convert the existing expenses to a list of Expenz objects
      List<Expenz> existingExpenzObjects = [];

      if(existingExpenzes != null){
        existingExpenzObjects = existingExpenzes.map((e) => Expenz.fromJSON(json.decode(e))).toList();
      }

      ///add the new expenz to the list
      existingExpenzObjects.add(expenz);

      ///convert the list of expenz objects back to a list of strings
      List<String> updatedExpenzes = existingExpenzObjects.map((e) => json.encode(e.toJSON())).toList();

      ///save the updated list of expenz to shared pref
      await prefs.setStringList(_expenzKey, updatedExpenzes);

      ///show message
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Expenz addeed successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }

    } catch(error) {
      ///show message
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error on adding Expenz!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  ///load the expenzes from shared pref
  Future<List<Expenz>> loadExpenzes () async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingExpenzes = pref.getStringList(_expenzKey);

    ///convert the existing expenzes to a list of expenz objects
    List<Expenz> loadedExpenzes = [];
    if(existingExpenzes != null){
      loadedExpenzes = existingExpenzes.map((e) => Expenz.fromJSON(json.decode(e))).toList();
    }
    return loadedExpenzes;
  }

  ///delete the expenz from shared preferences from the id
  Future<void> deleteExpenzes (int id, BuildContext context) async {
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? existingExpenzes = pref.getStringList(_expenzKey);

      ///convert the existing expenzes to a list of expenz objects
      List<Expenz> existingExpenzObjects = [];
      if(existingExpenzes != null){
        existingExpenzObjects = existingExpenzes.map((e) => Expenz.fromJSON(json.decode(e))).toList();
      }

      ///removes the expenz with the specified id from the list
      existingExpenzObjects.removeWhere((expenz) => expenz.id == id);

      ///convert the list of expenz objects back to a list of strings
      List<String> updatedExpenzes = existingExpenzObjects.map((e) => json.encode(e.toJSON())).toList();

      ///save the updated list of expenzes to the shared preferences
      await pref.setStringList(_expenzKey, updatedExpenzes);

      ///show snack bar success
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Expenzes deleted successfully"),
            duration: Duration(seconds: 2),
          )
        );
      }
    } catch(error){
      print(error.toString());

      ///show snack bar
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error Expenzes deleted"),
              duration: Duration(seconds: 2),
            )
        );
      }
    }
  }

}