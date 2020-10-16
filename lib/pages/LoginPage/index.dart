import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Tabs.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage>{

  String _username;
  String _verificationcode;
  String _btVCText;
  bool _disabled;
  var zHeight;
  void initState() {
    // TODO: implement initState super.initState();
    print('initState');
    _btVCText = '获取验证码';
    _disabled = false;
    zHeight = MediaQueryData.fromWindow(window).padding.top;
  }
  //登录
  void _loginOut() {
    print(_username);
    print(_verificationcode);
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(
            builder: (context) => new Tabs(index: 0)
        ),
        (route) => route == null
    );
  }
  //获取验证码
  void _getVC() {
    print('获取验证码');
    setInter(countDown: 30);
  }

  void setInter({int countDown = 60}) {
    setState(() {
      this._disabled = true;
      this._btVCText = countDown.toString();
    });
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if(!mounted){
        timer.cancel();
        return;
      }
      countDown--;
      setState(() {
        this._btVCText = countDown.toString();
      });
      if (countDown < 1) {
        //可以使用timer.cancel()来取消定时器，避免无限回调
        timer.cancel();
        setState(() {
          this._disabled = false;
          this._btVCText = "获取验证码";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: this.zHeight,),
          Container(
            height: 88 - this.zHeight,
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  child: IconButton(
                    icon: Icon(Icons.keyboard_backspace, color: Colors.black,),
                    onPressed: () { Navigator.pop(context); },
                  ),
                ),
                // Icon(Icons.keyboard_backspace)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: 50,
                bottom: 50
            ),
            child: Center(
              child: Text('欢迎来到摄图',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'PingFang SC'
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20
            ),
            width: double.infinity,
            height: 55,
            margin: EdgeInsets.only(
              left: 38,
              right: 38
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(245, 245, 245, 1),
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            child: Row(
              children: [
                Icon(Icons.phone_iphone, size: 24,),
                SizedBox(width: 10,),
                Container(
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 20
                  ),
                  child: VerticalDivider(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 1,
                  child: TextField(
                    maxLength: 11,
                    onChanged: (value) {
                      setState(() {
                        this._username = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: '请输入手机号',
                      contentPadding: EdgeInsets.all(5.0),
                      border: InputBorder.none,  // 去掉下滑线
                      counterText: '', // 去除输入框底部的字符计数
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 15,),
          Container(
            padding: EdgeInsets.only(
                left: 20,
                right: 20
            ),
            width: double.infinity,
            height: 55,
            margin: EdgeInsets.only(
                left: 38,
                right: 38
            ),
            decoration: BoxDecoration(
                color: Color.fromRGBO(245, 245, 245, 1),
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            child: Row(
              children: [
                Icon(Icons.https, size: 24,),
                SizedBox(width: 10,),
                Container(
                  padding: EdgeInsets.only(
                      top: 20,
                      bottom: 20
                  ),
                  child: VerticalDivider(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                SizedBox(width: 12,),
                Expanded(
                  flex: 1,
                  child: TextField(
                    maxLength: 6,
                    onChanged: (value) {
                      setState(() {
                        this._verificationcode = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: '请输入验证码',
                      contentPadding: EdgeInsets.all(5.0),
                      border: InputBorder.none,  // 去掉下滑线
                      counterText: '', // 去除输入框底部的字符计数
                    ),
                  ),
                ),
                Container(
                  width: 90,
                  margin: EdgeInsets.only(
                    top: 14,
                    bottom: 14
                  ),
                  child: RaisedButton(
                    child: Text(this._btVCText,
                      style: TextStyle(
                        fontSize: 10
                      ),
                    ),
                    textColor: Colors.white,
                    color: Colors.black,
                    elevation:10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onPressed: this._disabled ? null : _getVC,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 15,
              bottom: 15
            ),
            child: Text('未注册的手机号验证后自动创建摄图账号',
              style: TextStyle(
                fontSize: 13,
                color: Color.fromRGBO(200, 200, 200, 1),
                fontFamily: 'PingFang SC'
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 55,
            margin: EdgeInsets.only(
                left: 38,
                right: 38
            ),
            child: RaisedButton(
              child: Text('登录',
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              textColor: Colors.white,
              color: Colors.black,
              elevation:10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: _loginOut,
            ),
          ),
          SizedBox(height: 30,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 30,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(Icons.pets, color: Colors.black,),
                        iconSize: 20,
                        onPressed: () {
                          print('微信');
                        },
                      ),
                    ),
                    Text('微信',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.black
                      ),
                    )
                  ],
                ),
                Container(
                  height: 10,
                  child: VerticalDivider(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 30,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: Icon(Icons.pets, color: Colors.black,),
                        iconSize: 20,
                        onPressed: () {
                          print('QQ');
                        },
                      ),
                    ),
                    Text('QQ',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.black
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  bottom: 30,
                  child: Row(
                    children: [
                      Text('登录即同意',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color.fromRGBO(200, 200, 200, 1)
                        ),
                      ),
                      FlatButton(
                        minWidth: 10,//关键是这里设置一个较小值就行了
                        height: 10,
                        padding: EdgeInsets.all(1.0),
                        child: Text('用户协议',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 13,
                              color: Color.fromRGBO(200, 200, 200, 1)
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'ua');
                        },
                      ),

                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}