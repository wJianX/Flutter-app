import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../res/listData.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  bool _isPC;
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    controller = new AnimationController(
        duration: const Duration(milliseconds: 5000), vsync: this);
    animation = new Tween(begin: 0.0, end: 100.0).animate(controller);
    controller.forward();
    this._isPC = false;
    super.initState();
  }

  List<Widget> _getListPhoneData() {
    var listData = _isPC ? listDataPc : listDataPhone;
    var tempList = listData.map((value){
      return Tile(value["imageUrl"], value["title"], value["details"], value["download"], animation: animation);
    }); // ('124124','124214')
    return tempList.toList();
  }
  List<StaggeredTile> _staggeredTile() {
    var listData = _isPC ? listDataPc : listDataPhone;
    var tempList = listData.map((value){
      if(value['type'] == 2) {
        return const StaggeredTile.fit(4);
      }else{
        return const StaggeredTile.fit(2);
      }
    }); // ('124124','124214')
    return tempList.toList();
  }



  void _switchPlatform() {
    setState(() {
      this._isPC = !this._isPC;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(245, 245, 245, 1),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: FlatButton(
                  highlightColor: Colors.transparent,  //去掉点击的时候的高亮效果
                  splashColor: Colors.transparent,  //去掉 点击后不松手的扩散效果
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20), ),
                  onPressed: (){
                    print('点击了搜索');
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: 14
                        ),
                        child: Image.asset('images/icon/search.png',
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        '搜索热门地址',
                        style: TextStyle(
                            color: Color.fromRGBO(213, 213, 213, 1),
                            fontSize: 14
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: 12
              ),
              width: 36,
              height: 24,
              child: IconButton(
                highlightColor: Colors.transparent,  //去掉点击的时候的高亮效果
                splashColor: Colors.transparent,
                padding: EdgeInsets.all(0),
                icon: Image.asset(this._isPC ? 'images/icon/icon_pc.png' : 'images/icon/icon_phone.png',
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
                onPressed: _switchPlatform,
              ),
            )
          ],
        ),
      ),
      body: new StaggeredGridView.count(
        padding: EdgeInsets.only(
          left: 12,
          right: 12
        ),
        primary: false,
        crossAxisCount: 4,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 4.0,
        children: this._getListPhoneData(),
        staggeredTiles: this._staggeredTile(),
      ),
    );
  }
}



class Tile extends AnimatedWidget {
  Tile(this.source, this.title, this.details, this.download, {Key key, Animation<double> animation}): super(key: key, listenable: animation);
  final String source;
  final String title;
  final String details;
  final String download;

  @override
  Widget build(BuildContext context) {
    return new Card(
      margin: EdgeInsets.only(
        top: 0
      ),
      elevation: 0,
      color: Color.fromRGBO(250, 250, 250, 1),
      child: new Column(
        children: <Widget>[
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Image.network(source),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 15,
              bottom: 18
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  this.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        this.details,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Color.fromRGBO(223, 223, 223, 1), fontSize: 14),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('images/icon/icon_download.png',
                              width: 12,
                              height: 12,
                            ),
                            Text(this.download,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(213, 213, 213, 1)
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          // Container(
          //   height: animation.value,
          //   width: animation.value,
          // )
        ],
      ),
    );
  }
}