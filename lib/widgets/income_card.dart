import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/income_model.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class IncomeCard extends StatelessWidget {

  final String title;
  final DateTime date;
  final double amount;
  final IncomeCategory category;
  final String description;
  final DateTime time;

  const IncomeCard({
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
      padding: EdgeInsets.all(15),
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
              color: incomeCategoryColor[category]!.withOpacity(0.5),
            ),
            child: Image.asset(
              incomeCategoryImages[category]!,
              width: 20,
              height: 20,
            ),
          ),
          SizedBox(width: 20,),
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
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "+\$${amount.toStringAsFixed(0)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kGreen,
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
