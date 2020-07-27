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


  @override
  void initState(){
    super.initState();

    _appBarAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 0));

    _appBarAnimationHeightTween = Tween(begin: 0.0, end: HomePageViewConfig.fullAppBarHeight)
                                    .animate(_appBarAnimationController);

    _bodyScrollController = ScrollController();
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

      body: SingleChildScrollView(child: Column(children: [
        Text('T', style: TextStyle(fontSize: 200),),
        Text('T', style: TextStyle(fontSize: 200),),
        Text('T', style: TextStyle(fontSize: 200),),
        Text('T', style: TextStyle(fontSize: 200),),
      ])))

  );
}