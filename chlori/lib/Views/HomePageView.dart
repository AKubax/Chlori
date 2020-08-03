import 'package:chlori/Controllers/DataProvider.dart';
import 'package:chlori/Controllers/StorageManager.dart';
import 'package:chlori/Models/FoodIntake.dart';
import 'package:chlori/Models/Meal.dart';
import 'package:flutter/material.dart';

import 'ViewsConfig.dart';

class HomePageView extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>_HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> with TickerProviderStateMixin{
  AnimationController _appBarAnimationController;
  Animation _appBarAnimationHeightTween;

  ScrollController _bodyScrollController;
  bool _justHandledOnScroll = false;

  List<FoodIntake> foodIntakeList;

  @override
  void initState(){
    super.initState();

    _appBarAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 0));
    _appBarAnimationHeightTween = Tween(begin: 0.0, end: HomePageViewConfig.fullAppBarHeight)
                                    .animate(_appBarAnimationController);
    _bodyScrollController = ScrollController();

    DataProvider.foodIntakeList.then((value) => setState((){foodIntakeList = value;}));

    StorageManager.writeDummyFoodsListFile();
  }

  bool _onScroll(ScrollNotification event){
    if(_justHandledOnScroll){
      _justHandledOnScroll = false;
      return false;
    }

    if(event.metrics.axis != Axis.vertical) return false;

    _justHandledOnScroll = true;
    _appBarAnimationController.animateTo((1 / 5) * event.metrics.pixels / HomePageViewConfig.fullAppBarHeight);
    //_bodyScrollController.jumpTo(event.metrics.pixels);

    return true;
  }

  @override
  Widget build(BuildContext context) => NotificationListener<ScrollNotification>(
    onNotification: _onScroll,
    child: Scaffold(
      appBar: PreferredSize(preferredSize: Size(double.infinity, 100), child: AnimatedBuilder(
        animation: _appBarAnimationController,
        builder: (context, child) => Container(
          width: MediaQuery.of(context).size.width,
          height: _appBarAnimationHeightTween.value,
          child: Stack(alignment: Alignment.bottomCenter, children: [
//            SafeArea(child: SizedBox(height: double.infinity, child: LinearProgressIndicator(value: 0.5),)),
            SizedBox(height: double.infinity, child: LinearProgressIndicator(value: 0.5),),
            SafeArea(child: Text('Chlori', style: Theme.of(context).textTheme.headline2,),),
          ],),
        )
      )),

      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          _daySummary(),
          Column(children: foodIntakeList == null? [] : foodIntakeList.map(
                  (item) => _foodIntakeSummary(item.name, item.time, item.meals)
          ).toList())
        ]))
      ),
    )
  );

  Widget _daySummary() => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      color: Colors.cyanAccent.withAlpha(20),
    ),
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Stack(alignment: Alignment.center, children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width / 2,
          child: CircularProgressIndicator(value: 0.5)
        ),
        Column(children: [
          Text('587', style: Theme.of(context).textTheme.headline2),
          Text('kcal', style: Theme.of(context).textTheme.bodyText1),
        ]),
      ]),
      Padding(padding: EdgeInsets.all(7.5)),
      _macronutrientRow('Protein'),
      _macronutrientRow('Fat'),
      _macronutrientRow('Carbs'),
    ],),
  );

  Widget _macronutrientRow(String name) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Text(name, style: Theme.of(context).textTheme.caption),
    SizedBox(width: MediaQuery.of(context).size.width * 0.65, child: LinearProgressIndicator(value: 0.2)),
  ]);

  Widget _foodIntakeSummary(String foodIntakeName, TimeOfDay time, List<Meal> meals) => Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.grey.withOpacity(0.1),
    ),

    child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Row(children: [
            Icon(Icons.alarm),
            Text((time.hour < 10? '0' : '') + time.hour.toString() +
                ':' +
                (time.minute < 10? '0' : '') + time.minute.toString())
          ]),
        ),
        Text(foodIntakeName, style: Theme.of(context).textTheme.headline5),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Icon(Icons.add),
          ],),
        ),
      ],),

      Column(crossAxisAlignment: CrossAxisAlignment.center, children: meals.map((meal) => _mealMiniCard(meal)).toList())
    ],)
  );

  Widget _mealMiniCard(Meal meal) => Container(
    margin: EdgeInsets.all(5),
    padding: EdgeInsets.all(3),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      color: Colors.white.withOpacity(0.8),
    ),

    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,

        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(meal.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          Text(meal.weight.toString() + 'g', style: TextStyle(fontSize: 14)),
        ],),
      ),

      Row(children: [
        _valueMicroColumn(
          'P',
          meal.protein,
          'g',
          HomePageViewConfig.macroLabelSize,
          HomePageViewConfig.macroLabelSize * HomePageViewConfig.mealMiniCardValueMultipier
        ),
        VerticalDivider(),
        _valueMicroColumn(
          'F',
          meal.fats,
          'g',
          HomePageViewConfig.macroLabelSize,
          HomePageViewConfig.macroLabelSize * HomePageViewConfig.mealMiniCardValueMultipier
        ),
        VerticalDivider(),
        _valueMicroColumn(
          'C',
          meal.carbs,
          'g',
          HomePageViewConfig.macroLabelSize,
          HomePageViewConfig.macroLabelSize * HomePageViewConfig.mealMiniCardValueMultipier
        ),
        VerticalDivider(),
        //VerticalDivider(),
        _valueMicroColumn(
          'K',
          meal.kcal,
          'kcal',
          HomePageViewConfig.macroLabelSize * 1.25,
          HomePageViewConfig.macroLabelSize * HomePageViewConfig.mealMiniCardValueMultipier
        ),
      ])
    ],)
  );

  Widget _valueMicroColumn(String label, double value, String units, double labelSize, double valueSize) => Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: labelSize)),
      Row(
        mainAxisAlignment : MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
              value.toString(),
              style: TextStyle(
                  fontSize: valueSize
              )
          ),
          Text(units)
        ],
      )
    ],
  );
}