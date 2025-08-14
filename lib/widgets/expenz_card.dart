import 'package:expenz/models/expenz_model.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenzCard extends StatelessWidget {

  final String title;
  final DateTime date;
  final double amount;
  final ExpenzCategory category;
  final String description;
  final DateTime time;

  const ExpenzCard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.category,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(kDefalutPadding),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: kGrey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 1),
          )
        ]
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: expenzCategoriesColors[category]!.withOpacity(0.5),
            ),
            child: Image.asset(
              expenzCategoriesImages[category]!,
              width: 20,
              height: 20,
            ),
          ),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kBlack,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                description,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: kGrey,
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "-\$${amount.toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kRed,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                DateFormat.jm().format(date),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: kGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
