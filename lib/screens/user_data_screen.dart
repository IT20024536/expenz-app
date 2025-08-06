import 'package:expenz/screens/main_screen.dart';
import 'package:expenz/services/user_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {

  bool rememberMe = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conformPasswordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    conformPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(kDefalutPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Enter Your\nPersonal Details",
                    style: TextStyle(
                      color: kBlack,
                      fontWeight: FontWeight.w500,
                      fontSize: 25
                    ),
                  ),
                  SizedBox(height: 30,),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: userNameController,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter your name";
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: EdgeInsets.all(20),
                          ),
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: emailController,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter your email";
                            }
                          },
                          decoration: InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              contentPadding: EdgeInsets.all(20),
                          ),
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: passwordController,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter your password";
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            contentPadding: EdgeInsets.all(20),
                          ),
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: conformPasswordController,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Please enter your conform password";
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Conform Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            contentPadding: EdgeInsets.all(20),
                          ),
                        ),
                        SizedBox(height: 25,),
                        Row(
                          children: [
                            Text(
                              "Remember me for the next time",
                              style: TextStyle(
                                fontSize: 15,
                                color: kGrey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                activeColor: kMainColor,
                                value: rememberMe,
                                onChanged: (value){
                                  setState(() {
                                    rememberMe = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        GestureDetector(
                          onTap: () async {
                            if(formKey.currentState!.validate()){
                              String userName = userNameController.text;
                              String email = emailController.text;
                              String password = passwordController.text;
                              String conformPassword = conformPasswordController.text;

                              await UserService.storeUserDetails(
                                  userName: userName,
                                  email: email,
                                  password: password,
                                  conformPassword: conformPassword,
                                  context: context);
                              
                              if(context.mounted){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) {
                                          return MainScreen();
                                        })
                                );
                              }

                            }
                          },
                          child: CustomButton(
                              buttonName: "Next",
                              buttonColor: kMainColor
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
