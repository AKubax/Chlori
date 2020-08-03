import 'package:chlori/Models/Meal.dart';
import 'package:flutter/material.dart';



class FoodIntake{
  final String name;
  final TimeOfDay time;
  final List<Meal> meals;

  const FoodIntake({this.name, this.time, this.meals});

  static const List<FoodIntake> dummyFoodIntakeList = [
    const FoodIntake(name: 'Breakfast', time: TimeOfDay(hour: 8, minute: 0), meals: [Meal.dummyMeal]),
    const FoodIntake(name: 'Lunch', time: TimeOfDay(hour: 15, minute: 0), meals: [Meal.dummyMeal, Meal.dummyMeal]),
    const FoodIntake(name: 'Supper', time: TimeOfDay(hour: 18, minute: 0), meals: [Meal.dummyMeal]),
  ];
}