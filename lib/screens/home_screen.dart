import 'package:expenz/services/user_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/income_expenz_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ///for store the username
  String username = "";

  @override
  void initState() {

    ///get the username from the sharedPref
    UserService.getUserData().then((value){
      if(value["username"] != null){
        setState(() {
          username = value["username"]!;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  decoration: BoxDecoration(
                    color: kMainColor.withOpacity(0.50),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(kDefalutPadding),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: kMainColor,
                                border: Border.all(
                                  color: kMainColor,
                                  width: 3,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                    "assets/images/user.jpg",
                                  fit: BoxFit.cover,
                                  width: 50,
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Text(
                                "Welcome $username",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: (){},
                                icon: Icon(
                                    Icons.notifications,
                                  size: 30,
                                )
                            )
                          ],
                        ),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IncomeExpenzCard(
                              title: "Income",
                              imageUrl: "assets/images/income.png",
                              amount: 5000,
                              bgColor: kGreen,
                            ),
                            IncomeExpenzCard(
                              title: "Expenses",
                              imageUrl: "assets/images/expense.png",
                              amount: 1200,
                              bgColor: kRed,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
