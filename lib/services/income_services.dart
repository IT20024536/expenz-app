import 'dart:convert';

import 'package:expenz/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeServices{

  ///Income
  List<Income> incomeList = [];

  ///define the key for storing incomes in shared pref
  static const String _incomeKey = 'income';

  ///save the income to shared pref
  Future<void> saveIncome(Income income, BuildContext context) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      ///convert the existing incomes to a list of Incomes object
      List<Income> existingIncomeObjects = [];

      if(existingIncomes != null){
        existingIncomeObjects = existingIncomes.map((e) => Income.fromJSON(json.decode(e))).toList();
      }

      ///add the new Income to the list
      existingIncomeObjects.add(income);

      ///convert the list of income objects back to a list of strings
      List<String> updatedIncomes = existingIncomeObjects.map((e) => json.encode(e.toJSON())).toList();

      ///save the updated list of incomes to shared pref
      await prefs.setStringList(_incomeKey, updatedIncomes);

      ///show message
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Income added successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch(error){

      ///show message
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error on adding income"),
            duration: Duration(seconds: 2),
          ),
        );
      }

    }

  }

  ///load the income from shared pref
  Future<List<Income>> loadIncomes () async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingIncomes = pref.getStringList(_incomeKey);

    ///convert the existing Incomes to a list of income objects
    List<Income> loadedIncomes = [];
    if(existingIncomes != null){
      loadedIncomes = existingIncomes.map((e) => Income.fromJSON(json.decode(e))).toList();
    }
    return loadedIncomes;
  }

  ///delete the expenz from shared preference from the id
  Future<void> deleteIncomes(int id, BuildContext context) async {
    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? existingIncomes = pref.getStringList(_incomeKey);

      ///convert the existing incomes to a list of incomes object
      List<Income> existingIncomeObjects = [];
      if(existingIncomes != null){
        existingIncomeObjects = existingIncomes.map((e) => Income.fromJSON(json.decode(e))).toList();
      }

      ///removes the income with the specified id from the list
      existingIncomeObjects.removeWhere((income) => income.id == id);

      ///convert the list of income objects back to a list of strings
      List<String> updatedIncomes = existingIncomeObjects.map((e) => json.encode(e.toJSON())).toList();

      ///save the updated list of income to the shared pref
      await pref.setStringList(_incomeKey, updatedIncomes);

      ///show snack bar success
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Incomes deleted successfully"),
              duration: Duration(seconds: 2),
            )
        );
      }

    } catch (error){
      print(error.toString());

      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Error Incomes deleted"),
              duration: Duration(seconds: 2),
            )
        );
      }
    }
  }

}