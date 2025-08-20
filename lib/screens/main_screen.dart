import 'package:expenz/models/expenz_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/screens/add_new_screen.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profile_screen.dart';
import 'package:expenz/screens/transaction_screen.dart';
import 'package:expenz/services/expenz_services.dart';
import 'package:expenz/services/income_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentPageIndex = 0;
  List<Expenz> expenzList = [];
  List<Income> incomeList = [];

  ///function to fetch expenz
  void fetchAllExpenzes() async {
    List<Expenz> loadedExpenzes = await ExpenzServices().loadExpenzes();
    setState(() {
      expenzList = loadedExpenzes;
    });
  }

  ///function to fetch income
  void fetchAllIncomes() async {
    List<Income> loadedIncomes = await IncomeServices().loadIncomes();
    setState(() {
      incomeList = loadedIncomes;
    });
  }

  ///function to add a new expenz
  void addNewExpenz(Expenz newExpenz){
    ExpenzServices().saveExpenzes(newExpenz, context);

    ///update the list of expenz
    setState(() {
      expenzList.add(newExpenz);
    });
  }

  ///function to add a new income
  void addNewIncome(Income newIncome){
    IncomeServices().saveIncome(newIncome, context);

    ///update the list of income
    setState(() {
      incomeList.add(newIncome);
    });
  }

  ///function to remove expenz from the list
  void removeExpenz(Expenz expenz){
    ExpenzServices().deleteExpenzes(expenz.id, context);
    setState(() {
      expenzList.remove(expenz);
    });
  }

  ///function to remove income from the list
  void removeIncome(Income income){
    IncomeServices().deleteIncomes(income.id, context);
    setState(() {
      incomeList.remove(income);
    });
  }

  ///category total expenze
  Map<ExpenzCategory, double> calculateExpenzCategories(){
    Map<ExpenzCategory, double> categoryTotals = {
      ExpenzCategory.food : 0,
      ExpenzCategory.health : 0,
      ExpenzCategory.shopping : 0,
      ExpenzCategory.subscriptions : 0,
      ExpenzCategory.transport : 0,
    };

    for(Expenz expenz in expenzList){
      categoryTotals[expenz.category] = categoryTotals[expenz.category]! + expenz.amount;
    }
    return categoryTotals;
  }

  ///category total incomes
  Map<IncomeCategory, double> calculateIncomeCategories(){
    Map<IncomeCategory, double> categoryTotals = {
      IncomeCategory.salary : 0,
      IncomeCategory.freelance : 0,
      IncomeCategory.passive : 0,
      IncomeCategory.sales : 0,
    };

    for(Income income in incomeList){
      categoryTotals[income.category] = categoryTotals[income.category]! + income.amount;
    }
    return categoryTotals;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchAllExpenzes();
      fetchAllIncomes();
    });
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      BudgetScreen(
        incomeCategoryTotals: calculateIncomeCategories(),
        expenzeCategoryTotals: calculateExpenzCategories(),
      ),
      HomeScreen(
        expenzesList: expenzList,
        incomesList: incomeList,
      ),
      TransactionScreen(
        expenzesList: expenzList,
        incomesList: incomeList,
        onDismissedExpenz: removeExpenz,
        onDismissedIncome: removeIncome,
      ),
      AddNewScreen(
        addExpenz: addNewExpenz,
        addIncome: addNewIncome,
      ),
      // BudgetScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          backgroundColor: kWhite,
          selectedItemColor: kMainColor,
          unselectedItemColor: kGrey,
          currentIndex: currentPageIndex,
          onTap: (index){
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_rounded),
              label: "Transaction",
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kMainColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  color: kWhite,
                  size: 30,
                ),
              ),
              label: ""
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              label: "Budget",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ]
      ),
      body: pages[currentPageIndex],
    );
  }
}
