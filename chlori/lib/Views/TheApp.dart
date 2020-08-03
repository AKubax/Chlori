import 'package:flutter/material.dart';
import 'HomePageView.dart';


class TheApp extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _TheAppState();
}

class _TheAppState extends State<TheApp> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState(){
    super.initState();

    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    bottomNavigationBar: _navBar(),
    body: TabBarView(controller: _tabController, children: [
      HomePageView(),
      Icon(Icons.fastfood),
    ]),
  );

  Widget _navBar() => Container(
    color: Colors.grey.withOpacity(0.25),
    child: TabBar(controller: _tabController, tabs: [
      Tab(icon: Icon(Icons.home), ),
      Tab(icon: Icon(Icons.fastfood))
    ],),
  );
}