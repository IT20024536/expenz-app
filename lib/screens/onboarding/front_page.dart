import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/logo.png",
          width: 100,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 20,),
        Text(
          "Expenz",
          style: TextStyle(
            color: kMainColor,
            fontSize: 40,
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}
