import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Tabs/HomePage.dart';
import 'Tabs/MsgPage.dart';
import 'Tabs/MyPage.dart';
import 'Tabs/SortPage.dart';

class Tabs extends StatefulWidget{
  final index;
  Tabs({Key key, this.index}) : super(key: key);
  @override
  _TabsState createState() => new _TabsState(this.index);
}

class _TabsState extends State<Tabs> with TickerProviderStateMixin{
  List<BottomNavigationBarItem> bottomNavItems;
  _TabsState(index){
    this.currentIndex = index;
  }
  int currentIndex;

  //1. 创建页面控制器
  var _pageController;

  // 旋转
  AnimationController animationController;
  Animation animation;

  // 摇摆
  Animation<double> customAnimation;
  AnimationController customController;

  @override
  void initState(){
    //2. 页面控制器初始化
    _pageController = new PageController(initialPage : currentIndex);

    //点击item动画

    animationController = AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = Tween(begin: 0.0, end: 2.0 * pi).animate(animationController);

    customController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    customAnimation = TweenSequence<double>([//使用TweenSequence进行多组补间动画
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: 25), weight: 5),
      TweenSequenceItem<double>(tween: Tween(begin: 25, end: 0), weight: 5),
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: -23), weight: 4.8),
      TweenSequenceItem<double>(tween: Tween(begin: -23, end: 0), weight: 4.8),
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: 18), weight: 3.2),
      TweenSequenceItem<double>(tween: Tween(begin: 18, end: 0), weight: 3.2),
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: -15), weight: 2.8),
      TweenSequenceItem<double>(tween: Tween(begin: -15, end: 0), weight: 2.8),
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: 8), weight: 1.3),
      TweenSequenceItem<double>(tween: Tween(begin: 8, end: 0), weight: 1.3),
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: -5), weight: 1),
      TweenSequenceItem<double>(tween: Tween(begin: -5, end: 0), weight: 1)
    ]).animate(customController);

    bottomNavItems = [
      BottomNavigationBarItem(
        icon: Image.asset(
          "images/tabs/home.png",
          width: 20,
          height: 20,
        ),
        activeIcon: AnimateWidget("images/tabs/home_a.png", animation: customAnimation),
        title: new Container(),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          "images/tabs/find.png",
          width: 20,
          height: 20,
        ),
        activeIcon: AnimateWidget("images/tabs/find_a.png", animation: customAnimation),
        title: new Container(),
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          "images/tabs/msg.png",
          width: 20,
          height: 20,
        ),
        activeIcon: AnimateWidget("images/tabs/msg_a.png", animation: customAnimation),
        title: new Container(),
      ),
      BottomNavigationBarItem(
        icon: ClipOval(
          child: Image.asset('images/tabs/v2_q8xika.png',
            width: 20,
            height: 20,
            fit: BoxFit.cover,
          ),
        ),
        activeIcon: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return Transform.rotate(
              angle: animation.value,
              child: child,
            );
          },
          child: ClipOval(
            child: Image.asset('images/tabs/v2_q8xika.png',
              width: 20,
              height: 20,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: new Container(),
      ),
    ];
    super.initState();
  }

  final pages = [HomePage(), SortPage(), MsgPage(), MyPage()];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _changePage(index);
        },
        fixedColor: Colors.black,
      ),
      // 3. 必须用 PageView 加载不同的页面
      body: PageView(
        controller: _pageController,
        children: this.pages,
        onPageChanged: (index){
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  /*切换页面*/
  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    // 4.0
    if (index != currentIndex) {
      print(index);
      setState(() {
        _pageController.jumpToPage(index);
      });
      if(index == 3){
        animationController.forward();
        setState(() {
          animationController.forward(from: 0.0);  //回到启点 下次点击就可重新执行动画
        });
      }else{
        customController.forward();
        setState(() {
          customController.forward(from: 0.0);  //回到启点 下次点击就可重新执行动画
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    customController.dispose();
    super.dispose();
  }
}


class AnimateWidget extends AnimatedWidget{

  AnimateWidget(this.imgUrl, {Key key, Animation<double> animation})
      : super(key: key, listenable: animation);
  final imgUrl;
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    var result = Transform(
      transform: Matrix4.rotationZ(animation.value * pi / 180),
      alignment: Alignment.topCenter,
      child: Image.asset(
        imgUrl,
        width: 20,
        height: 20,
      ),
    );
    return result;
  }
}