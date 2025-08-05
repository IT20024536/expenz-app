import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String buttonName;
  final Color buttonColor;

  const CustomButton({
    super.key,
    required this.buttonName,
    required this.buttonColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: buttonColor,
      ),
      child: Center(
        child: Text(
          buttonName,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
