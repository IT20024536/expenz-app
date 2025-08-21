import 'package:expenz/services/expenz_services.dart';
import 'package:expenz/services/income_services.dart';
import 'package:expenz/services/user_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/profile_card.dart';
import 'onboarding_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  ///for store the username
  String username = "";

  @override
  void initState() {
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
                          )
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
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Username",
                                style: TextStyle(
                                  color: kGrey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                username,
                                style: TextStyle(
                                  color: kBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: (){},
                          icon: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kLightGrey,
                            ),
                            child: Icon(
                                Icons.edit_outlined,
                              size: 30,
                            ),
                          ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  ProfileCard(
                    color: kMainColor,
                    icon: Icons.wallet,
                    title: "My Wallet",
                  ),
                  ProfileCard(
                    color: kMainColor,
                    icon: Icons.settings,
                    title: "Settings",
                  ),
                  ProfileCard(
                    color: kMainColor,
                    icon: Icons.file_download_outlined,
                    title: "Export Data",
                  ),
                  GestureDetector(
                    onTap: (){
                      _showBottomSheet(context);
                    },
                    child: ProfileCard(
                      color: kRed,
                      icon: Icons.logout,
                      title: "Logout",
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            height: 150,
            padding: EdgeInsets.all(kDefalutPadding),
            child: Column(
              children: [
                Text(
                  "Are you sure,do you want to logout",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: kGrey,
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kMainColor.withOpacity(0.25)),
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                          "No",
                        style: TextStyle(
                          color: kMainColor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kMainColor),
                      ),
                      onPressed: () async {

                        ///clear the user data
                        await UserService.clearUserData();

                        if(context.mounted){
                          ///clear all expenzes
                          await ExpenzServices().deleteAllExpenzes(context);
                          ///clear all incomes
                          await IncomeServices().deleteAllIncomes(context);

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OnboardingScreen(),
                            ), (route) => false,
                          );

                        }

                      },
                      child: Text(
                          "Yes",
                        style: TextStyle(
                          color: kWhite,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
    );
  }

}
