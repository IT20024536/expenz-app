import 'package:flutter/material.dart';

///income category enum
enum IncomeCategory {
  freelance,
  salary,
  passive,
  sales,
}

///category images
final Map<IncomeCategory, String> incomeCategoryImages = {
  IncomeCategory.freelance:"assets/images/freelance.png",
  IncomeCategory.salary:"assets/images/salary.png",
  IncomeCategory.passive:"assets/images/health.png",
  IncomeCategory.sales:"assets/images/car.png",
};

///category colors
final Map<IncomeCategory, Color> incomeCategoryColor = {
  IncomeCategory.freelance: Color(0xFFE57373),
  IncomeCategory.salary: Color(0xFFFFD54F),
  IncomeCategory.passive: Color(0xFF81C784),
  IncomeCategory.sales: Color(0xFF64B5F6),
};

class Income {
  final int id;
  final String title;
  final double amount;
  final IncomeCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  Income({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
    required this.description
  });
}