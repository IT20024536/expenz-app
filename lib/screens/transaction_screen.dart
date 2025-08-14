import 'package:expenz/models/expenz_model.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:expenz/widgets/expenz_card.dart';
import 'package:flutter/material.dart';

import '../models/income_model.dart';
import '../widgets/income_card.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kDefalutPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "See your financial report",
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 30,),
                Text(
                  "Expenses",
                  style: TextStyle(
                    color: kBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20,),
                ExpenzCard(
                    title: "title",
                    date: DateTime.now(),
                    amount: 333,
                    category: ExpenzCategory.food,
                    description: "description",
                    time: DateTime.now(),
                ),
                SizedBox(height: 30,),
                Text(
                  "Income",
                  style: TextStyle(
                    color: kBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20,),
                IncomeCard(
                  title: "title",
                  date: DateTime.now(),
                  amount: 333,
                  category: IncomeCategory.salary,
                  description: "description",
                  time: DateTime.now(),
                )
              ],
            ),
          ),
      ),
    );
  }
}
