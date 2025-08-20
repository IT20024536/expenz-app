import 'package:expenz/models/expenz_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/utils/colors.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/budget_pie_chart.dart';
import '../widgets/category_card.dart';

class BudgetScreen extends StatefulWidget {

  final Map<ExpenzCategory, double> expenzeCategoryTotals;
  final Map<IncomeCategory, double> incomeCategoryTotals;

  const BudgetScreen({
    super.key,
    required this.expenzeCategoryTotals,
    required this.incomeCategoryTotals,
  });

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {

  int selectedMethod = 0;

  ///method to find the category color from the category
  Color getCategoryColor(dynamic category){
    if(category is ExpenzCategory){
      return expenzCategoriesColors[category]!;
    } else {
      return incomeCategoryColor[category]!;
    }
  }

  @override
  Widget build(BuildContext context) {

    final data = selectedMethod == 0 ? widget.expenzeCategoryTotals : widget.incomeCategoryTotals;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Financial Report",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: kBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kDefalutPadding,
                      vertical: kDefalutPadding,
                    ),
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.06,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              selectedMethod = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedMethod == 0 ? kMainColor : kWhite,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 60,
                                vertical: 10,
                              ),
                              child: Text(
                                  "Expense",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: selectedMethod == 0 ? kWhite : kBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              selectedMethod = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: selectedMethod == 1 ? kMainColor : kWhite
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 60,
                                vertical: 10,
                              ),
                              child: Text(
                                "Income",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: selectedMethod == 1 ? kWhite : kBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),

                ///pie chart
                BudgetPieChart(
                  expenzeCategoryTotals: widget.expenzeCategoryTotals,
                  incomeCategoryTotals: widget.incomeCategoryTotals,
                  isExpenz: selectedMethod == 0,
                ),
                SizedBox(height: 20,),

                ///list of categories
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.3,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context,index){

                        final category = data.keys.toList()[index];
                        final total = data.values.toList()[index];

                        return CategoryCard(
                          title: category.name,
                          amount: total,
                          total: data.values.reduce((value,element) => value + element),
                          progressColor: getCategoryColor(category),
                          isExpenz: selectedMethod == 0 ,
                        );
                      }
                  ),
                ),

              ],
            ),
          ),
      ),
    );
  }
}
