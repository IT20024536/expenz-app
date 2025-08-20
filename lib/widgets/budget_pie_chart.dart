import 'package:expenz/models/expenz_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BudgetPieChart extends StatefulWidget {

  final Map<ExpenzCategory , double> expenzeCategoryTotals;
  final Map<IncomeCategory , double> incomeCategoryTotals;
  final bool isExpenz;

  const BudgetPieChart({
    super.key,
    required this.expenzeCategoryTotals,
    required this.incomeCategoryTotals,
    required this.isExpenz,
  });

  @override
  State<BudgetPieChart> createState() => _BudgetPieChartState();
}

class _BudgetPieChartState extends State<BudgetPieChart> {

      List<PieChartSectionData> getSections() {
      if (widget.isExpenz) {
      return [
        PieChartSectionData(
          color: expenzCategoriesColors[ExpenzCategory.food],
          value: widget.expenzeCategoryTotals[ExpenzCategory.food] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenzCategoriesColors[ExpenzCategory.transport],
          value: widget.expenzeCategoryTotals[ExpenzCategory.transport] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenzCategoriesColors[ExpenzCategory.health],
          value: widget.expenzeCategoryTotals[ExpenzCategory.health] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenzCategoriesColors[ExpenzCategory.shopping],
          value: widget.expenzeCategoryTotals[ExpenzCategory.shopping] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenzCategoriesColors[ExpenzCategory.subscriptions],
          value: widget.expenzeCategoryTotals[ExpenzCategory.subscriptions] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
    } else {
      return [
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.freelance],
          value: widget.incomeCategoryTotals[IncomeCategory.freelance] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.salary],
          value: widget.incomeCategoryTotals[IncomeCategory.salary] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.passive],
          value: widget.incomeCategoryTotals[IncomeCategory.passive] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.sales],
          value: widget.incomeCategoryTotals[IncomeCategory.sales] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
    }
  }

  /// Calculate totals
  double getTotal() {
    if (widget.isExpenz) {
       return widget.expenzeCategoryTotals.values.fold(0, (sum, item) => sum + item);
    } else {
       return widget.incomeCategoryTotals.values.fold(0, (sum, item) => sum + item);
    }
  }

  @override
  Widget build(BuildContext context) {

    final PieChartData pieChartData = PieChartData(
      sectionsSpace: 0,
      centerSpaceRadius: 70,
      startDegreeOffset: -90,
      sections: getSections(),
      borderData: FlBorderData(show: false),
    );

    final double total = getTotal();

    return Container(
      height: 250,
      padding: EdgeInsets.all(kDefalutPadding),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(pieChartData),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.isExpenz ? "Expenses" : "Income",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: kBlack,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "\$ ${total.toStringAsFixed(0)}",  // format to 2 decimals
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),
              // Text(
              //   "70%",
              //   style: TextStyle(
              //     color: kBlack,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // SizedBox(height: 8,),
              // Text(
              //     "of 100%",
              //   style: TextStyle(
              //     color: kGrey,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
