import 'package:expenz/models/expenz_model.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:expenz/widgets/expenz_card.dart';
import 'package:flutter/material.dart';

import '../models/income_model.dart';
import '../widgets/income_card.dart';

class TransactionScreen extends StatefulWidget {

  final List<Expenz> expenzesList;
  final void Function(Expenz) onDismissedExpenz;
  final List<Income> incomesList;
  final void Function(Income) onDismissedIncome;

  const TransactionScreen({
    super.key,
    required this.expenzesList,
    required this.onDismissedExpenz,
    required this.incomesList,
    required this.onDismissedIncome,
  });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.30,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.expenzesList.length,
                              itemBuilder: (context, index){
                                final expenz = widget.expenzesList[index];
                                return Dismissible(
                                  key: ValueKey(expenz),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (direction){
                                    setState(() {
                                      widget.onDismissedExpenz(expenz);
                                    });
                                  },
                                  child: ExpenzCard(
                                    title: expenz.title,
                                    date: expenz.date,
                                    amount: expenz.amount,
                                    category: expenz.category,
                                    description: expenz.description,
                                    time: expenz.time,
                                  ),
                                );
                              }
                          ),
                        ],
                      ),
                    ),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.30,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.incomesList.length,
                              itemBuilder: (context, index){
                                final income = widget.incomesList[index];
                                return Dismissible(
                                  key: ValueKey(income),
                                  direction: DismissDirection.startToEnd,
                                  onDismissed: (direction){
                                    setState(() {
                                      widget.onDismissedIncome(income);
                                    });
                                  },
                                  child: IncomeCard(
                                    title: income.title,
                                    date: income.date,
                                    amount: income.amount,
                                    category: income.category,
                                    description: income.description,
                                    time: income.time,
                                  ),
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
