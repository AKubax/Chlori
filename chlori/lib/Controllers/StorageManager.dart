import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

const String foodsStorageFile = '/fstorage.json';

//{
//  'foods' : [
//    {'id' : 0,
//    'name' : 'Brick',
//    'protein' :12,
//    'fats' : 2,
//    'carbs' : 37,
//    'kcal' : 312,
//    'deleted' : false}
//  ]
//}

abstract class StorageManager{
  static Future<List<Map<String, dynamic>>> get foodsList async{
    String foodsStorageAsStr = await File((await getApplicationDocumentsDirectory()).path + foodsStorageFile)
                                .readAsString();
    Map<String, dynamic> foodsStorageJson = jsonDecode(foodsStorageAsStr);
    return (foodsStorageJson['foods'] as List<Map<String, dynamic>>);
  }

  static Future<void> writeDummyFoodsListFile() async{
    File((await getApplicationDocumentsDirectory()).path + foodsStorageFile).writeAsString(jsonEncode(
      {'foods' : [{'id': 0, 'name': 'Brick', 'protein': 12, 'fats': 2, 'carbs': 37, 'kcal': 312, 'deleted': false}]}
    ));
  }
}