import 'package:expenz/services/user_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:flutter/material.dart';

import '../models/expenz_model.dart';
import '../models/income_model.dart';
import '../services/expenz_services.dart';
import '../services/income_services.dart';
import '../widgets/LineChart.dart';
import '../widgets/expenz_card.dart';
import '../widgets/income_expenz_card.dart';

class HomeScreen extends StatefulWidget {

  final List<Expenz> expenzesList;
  final List<Income> incomesList;

  const HomeScreen({
    super.key,
    required this.expenzesList,
    required this.incomesList,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ///for store the username
  String username = "";

  double expenzTotal = 0;
  double incomeTotal = 0;

  // bool _loading = true;
  // @override
  // void initState() {
  //   super.initState();
  //   _loadAll();
  // }
  //
  // Future<void> _loadAll() async {
  //   /// 1) username
  //   final user = await UserService.getUserData();
  //
  //   /// 2) expenses from SharedPreferences
  //   var expenzes = await ExpenzServices().loadExpenzes();
  //
  //   /// 3) incomes from SharedPreferences (create a similar service like ExpenzServices)
  //   var incomes = await IncomeServices().loadIncomes(); // implement similarly
  //
  //   if (!mounted) return;
  //   setState(() {
  //     username = user["username"] ?? "";
  //     expenzes = expenzes;
  //     incomes = incomes;
  //     expenzTotal = expenzes.fold<double>(0, (s, e) => s + e.amount);
  //     incomeTotal = incomes.fold<double>(0, (s, i) => s + i.amount);
  //     _loading = false;
  //   });
  // }

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

    setState(() {
      ///total amount of expenzes
      for (var e = 0; e < widget.expenzesList.length; e++){
        expenzTotal += widget.expenzesList[e].amount;
      }

      ///total amount of incomes
      for (var i = 0; i < widget.incomesList.length; i++){
        incomeTotal += widget.incomesList[i].amount;
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                              amount: incomeTotal,
                              bgColor: kGreen,
                            ),
                            IncomeExpenzCard(
                              title: "Expenses",
                              imageUrl: "assets/images/expense.png",
                              amount: expenzTotal,
                              bgColor: kRed,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(kDefalutPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Spend Frequency",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: kBlack,
                        ),
                      ),
                      SizedBox(height: 20,),
                      MyLineChart(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Recent Transaction",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: kBlack,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: kMainColor.withOpacity(0.2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    "see all",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color: kMainColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Column(
                            children: [
                              widget.expenzesList.isEmpty
                              ? const Text(
                                "No Expenzes Added Yet, Add Some Expenz To Here!",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: kMainColor,
                                ),
                              ): ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: widget.expenzesList.length,
                                  itemBuilder: (context, index){
                                    final expenz = widget.expenzesList[index];
                                    return ExpenzCard(
                                      title: expenz.title,
                                      date: expenz.date,
                                      amount: expenz.amount,
                                      category: expenz.category,
                                      description: expenz.description,
                                      time: expenz.time,
                                    );
                                  }
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
