import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:flutter/material.dart';

class IncomeExpenzCard extends StatefulWidget {

  final String title;
  final double amount;
  final String imageUrl;
  final Color bgColor;

  const IncomeExpenzCard({
    super.key,
    required this.title,
    required this.amount,
    required this.imageUrl,
    required this.bgColor
  });

  @override
  State<IncomeExpenzCard> createState() => _IncomeExpenzCardState();
}

class _IncomeExpenzCardState extends State<IncomeExpenzCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.45,
      height: MediaQuery.of(context).size.height*0.1,
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefalutPadding),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.15,
              height: MediaQuery.of(context).size.height*0.15,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Image.asset(
                    widget.imageUrl,
                ),
              ),
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: kWhite
                  ),
                ),
                Text(
                  "\$${widget.amount.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: kWhite
                  ),

                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
