import 'package:expenz/models/expenz_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:flutter/material.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {

  ///state to track the expenz or income
  int selectedMethod = 0;
  ExpenzCategory expenzCategory = ExpenzCategory.health;
  IncomeCategory incomeCategory = IncomeCategory.salary;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedMethod == 0 ? kRed : kGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefalutPadding,),
            child: Stack(
              children: [

                ///expenz and income toggle menu
                Padding(
                  padding: const EdgeInsets.all(kDefalutPadding),
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.06,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              selectedMethod = 0;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: selectedMethod == 0 ? kRed : kWhite,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 60,
                                    vertical:10,
                                ),
                                child: Text(
                                    "Expenz",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: selectedMethod == 0 ? kWhite : kBlack,
                                  ),
                                ),
                              )
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              selectedMethod = 1;
                            });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: selectedMethod == 1 ? kGreen : kWhite,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 60,
                                  vertical:10,
                                ),
                                child: Text(
                                    "Income",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: selectedMethod == 1 ? kWhite : kBlack,
                                  ),
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///amount field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kDefalutPadding),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height*0.15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "How much?",
                          style: TextStyle(
                            color: kLightGrey.withOpacity(0.8),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextField(
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: kWhite,
                          ),
                          decoration: InputDecoration(
                              hintText: "0",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: kWhite,
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                ///user data form
                Container(
                  height: MediaQuery.of(context).size.height*0.6,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height*0.4,
                  ),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(kDefalutPadding),
                    child: Form(
                        child: Column(
                          children: [
                            ///category selector drop down
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: kDefalutPadding,
                                  horizontal: 20,
                                ),
                              ),
                                items: selectedMethod == 0 ?
                                ExpenzCategory.values.map((category){
                                  return DropdownMenuItem(
                                    value: category,
                                      child: Text(category.name),
                                  );
                                }).toList() :
                                IncomeCategory.values.map((category){
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name),
                                  );
                                }).toList(),
                                value: selectedMethod == 0
                                    ? expenzCategory : incomeCategory,
                                onChanged: (value){
                                  setState(() {
                                    selectedMethod == 0 ?
                                        expenzCategory = value as ExpenzCategory :
                                        incomeCategory = value as IncomeCategory;
                                  });
                                },
                            ),
                            SizedBox(height: 30,),

                            ///text fields
                            TextFormField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                hintText: "Title",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: kDefalutPadding,
                                  horizontal: 20,
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),
                            TextFormField(
                              controller: _descriptionController,
                              decoration: InputDecoration(
                                hintText: "Description",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: kDefalutPadding,
                                  horizontal: 20,
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),
                            TextFormField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Amount",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: kDefalutPadding,
                                  horizontal: 20,
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),

                          ],
                        ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
