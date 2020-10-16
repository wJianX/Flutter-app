import 'package:flutter/material.dart';

class StartUpPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset('images/start_up/start_up_back.jpg',
                alignment: Alignment.topCenter,
                width: double.infinity,
                fit: BoxFit.cover,
              )
          ),
          Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.center_focus_weak,color: Colors.white, size: 60.0,),
                  SizedBox(height: 20,),
                  Text('打开生活，发现美好', style: TextStyle(color: Colors.white, fontSize: 15.0),),
                  SizedBox(height: 20,),
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(232, 52, 52, 1),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: IconButton(
                      icon: Icon(Icons.east, color: Colors.white,),
                      onPressed: () { Navigator.pushNamed(context, "login"); },
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}