import 'package:flutter/material.dart';

class MsgPage extends StatefulWidget {
  @override
  _MsgPageState createState() => new _MsgPageState();
}

class _MsgPageState extends State<MsgPage> with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    // TODO: implement initState
    print('initState');
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this
    );

    _animationController.addListener(() {
      setState(() {});
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //执行结束反向执行
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //反向执行结束正向执行
        _animationController.forward();
      }
    });

    _animation = CurvedAnimation(parent: _animationController,curve: Curves.easeIn);
    // _animation = Tween(begin: 100.0, end: 300.0).animate(_animation);
    _animation = ColorTween(begin: Colors.red,end: Colors.blue).animate(_animation);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('dispose');
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('动画'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('开始动画'),
            onPressed: () {
              _animationController.forward();
            },
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                color: _animation.value,
              ),
            ),
          ),
        ],
      ),
    );
  }

}