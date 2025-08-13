import 'package:expenz/models/expenz_model.dart';
import 'package:expenz/screens/add_new_screen.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profile_screen.dart';
import 'package:expenz/screens/transaction_screen.dart';
import 'package:expenz/services/expenz_services.dart';
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

  ///function to fetch expenz
  void fetchAllExpenzes() async {
    List<Expenz> loadedExpenzes = await ExpenzServices().loadExpenzes();
    setState(() {
      expenzList = loadedExpenzes;
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

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchAllExpenzes();
    });
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      AddNewScreen(
        addExpenz: addNewExpenz,
      ),
      HomeScreen(),
      TransactionScreen(),
      //AddNewScreen(),
      BudgetScreen(),
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
