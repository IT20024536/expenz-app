import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

class SharedOnboardingScreen extends StatelessWidget {

  final String title;
  final String imagePath;
  final String description;

  const SharedOnboardingScreen({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefalutPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 300,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10,),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: kBlack,
            ),
          ),
          SizedBox(height: 10,),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 15,
              color: kGrey,
            ),
          )
        ],
      ),
    );
  }
}
