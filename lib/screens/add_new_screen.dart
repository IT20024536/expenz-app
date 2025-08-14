import 'package:expenz/models/expenz_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/services/expenz_services.dart';
import 'package:expenz/services/income_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:expenz/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewScreen extends StatefulWidget {
  
  final Function(Expenz) addExpenz;
  final Function(Income) addIncome;

  const AddNewScreen({
    super.key,
    required this.addExpenz,
    required this.addIncome,
  });

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
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();

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
          physics: ClampingScrollPhysics(),
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
                height: MediaQuery.of(context).size.height*0.7,
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

                          SizedBox(height: 20,),

                          ///date picker
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2020),
                                      lastDate: DateTime(2030),
                                  ).then((value){
                                    if(value != null) {
                                      setState(() {
                                        _selectedDate = value;
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: kMainColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                            Icons.calendar_month_outlined,
                                          color: kWhite,
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                            "Select Date",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: kWhite
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                  DateFormat.yMMMd().format(_selectedDate),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: kGrey,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10,),

                          ///time picker
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value){
                                    if(value != null) {
                                      setState(() {
                                        _selectedTime = DateTime(
                                          _selectedDate.year,
                                          _selectedDate.month,
                                          _selectedDate.day,
                                          value.hour,
                                          value.minute,
                                        );
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: kYellow,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later_outlined,
                                          color: kWhite,
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          "Select Time",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: kWhite
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.jm().format(_selectedTime),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: kGrey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),

                          Divider(
                            thickness: 5,
                            color: kLightGrey,
                          ),
                          SizedBox(height: 20,),

                          ///submit button
                          GestureDetector(
                            onTap: () async {

                              ///save the expenz or income data to shared pref
                              List<Expenz> loadedExpenzes = await ExpenzServices().loadExpenzes();
                              List<Income> loadedIncomes = await IncomeServices().loadIncomes();

                              if (selectedMethod == 0){

                              ///create the expenz to store
                              Expenz expenz = Expenz(
                                  id: loadedExpenzes.length + 1,
                                  title: _titleController.text,
                                  amount: _amountController.text.isEmpty
                                          ? 0 : double.parse(_amountController.text),
                                  category: expenzCategory,
                                  date: _selectedDate,
                                  time: _selectedTime,
                                  description: _descriptionController.text,
                                );
                              ///add expenz
                              widget.addExpenz(expenz);

                             } else {

                                ///create the income to store
                                Income income = Income(
                                    id: loadedIncomes.length + 1,
                                    title: _titleController.text,
                                    amount: _amountController.text.isEmpty
                                            ? 0 : double.parse(_amountController.text),
                                    category: incomeCategory,
                                    date: _selectedDate,
                                    time: _selectedTime,
                                    description: _descriptionController.text,
                                );
                                ///add income
                                widget.addIncome(income);

                             }


                            },
                            child: CustomButton(
                                buttonName: "Add",
                                buttonColor: selectedMethod == 0 ? kRed : kGreen,
                            ),
                          ),

                        ],
                      ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
