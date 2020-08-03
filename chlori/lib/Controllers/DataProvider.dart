import 'package:chlori/Models/FoodIntake.dart';




class DataProvider{

  static Future<int> get foodIntakesCounter async => 3; //clearly, TODO
  static Future<List<FoodIntake>> get foodIntakeList async => FoodIntake.dummyFoodIntakeList;
}