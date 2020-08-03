


class Meal{
  final Food product;
  final double weight; //weight in grams

  String get name => product.name;

  double get protein => product.protein * weight / 100.0;
  double get fats => product.fats * weight / 100.0;
  double get carbs => product.carbs * weight / 100.0;

  double get kcal => product.kcal * weight / 100.0;

  const Meal({this.product, this.weight});


  static const Meal dummyMeal = const Meal(product: Food.dummyFood, weight: 80);
}

class Food{
  final String name;
  final double protein;   //per 100g
  final double fats;      //per 100g
  final double carbs;     //per 100g
  final double kcal;      //per 100g

  const Food({this.name, this.protein, this.fats, this.carbs, this.kcal});


  static const Food dummyFood = const Food(name: 'Brick', protein: 12, fats: 2, carbs: 37, kcal: 312);
}