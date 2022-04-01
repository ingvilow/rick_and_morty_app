
// @dart=2.9


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetrailedPage extends StatefulWidget {
  const DetrailedPage({Key key}) : super(key: key);

  @override
  _DetrailedPageState createState() => _DetrailedPageState();
}

class _DetrailedPageState extends State<DetrailedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50,),
          Center(
            child: Card(
                child: Container(
                  color: Colors.lime,
                  width: 300,
                  height: 300,
                ),
              ),
          ),
          const SizedBox(height: 25,),
          TweenAnimationBuilder(
            duration: const Duration(seconds: 10),
            builder: (_, Color color, __) {
              return ColorFiltered(colorFilter: ColorFilter.mode(color, BlendMode.modulate), child:Container(
                width: 300,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.indigoAccent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Text('here is the description', style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),);
            },
            tween: ColorTween(begin: Colors.lime, end: Colors.yellow),
          )
        ],
      ),
    );
  }
}
