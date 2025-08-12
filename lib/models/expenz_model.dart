import 'package:flutter/material.dart';

///enum for expenz categories
enum ExpenzCategory {
  food,
  transport,
  health,
  shopping,
  subscriptions,
}

///category images
final Map<ExpenzCategory, String> expenzCategoriesImages = {
  ExpenzCategory.food : "assets/images/restaurant.png",
  ExpenzCategory.transport : "assets/images/car.png",
  ExpenzCategory.health : "assets/images/health.png",
  ExpenzCategory.shopping : "assets/images/bag.png",
  ExpenzCategory.subscriptions : "assets/images/bill.png",
};

///category colors
final Map<ExpenzCategory, Color> expenzCategoriesColors = {
  ExpenzCategory.food : Color(0xFFE57373),
  ExpenzCategory.transport : Color(0xFF81C784),
  ExpenzCategory.health : Color(0xFF6485F6),
  ExpenzCategory.shopping : Color(0xFFFFD54F),
  ExpenzCategory.subscriptions : Color(0xFF9575CD),
};

class Expenz {
  final int id;
  final String title;
  final double amount;
  final ExpenzCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  Expenz({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
    required this.description,
  });
}