import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/model/characterId.dart';
import 'package:rick_and_morty_app/model/characters.dart';
import 'package:rick_and_morty_app/providers/animation_controller.dart';
import 'package:rick_and_morty_app/repository/hive_service.dart';

class DetrailedPage extends StatefulWidget {
  String? name;

  DetrailedPage({Key? key, this.name}) : super(key: key);

  @override
  _DetrailedPageState createState() => _DetrailedPageState();
}

class _DetrailedPageState extends State<DetrailedPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Alignment _dragAlignment = Alignment.center;
  Animation<Alignment>? _animation;

  void setAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _controller?.drive(AlignmentTween(
      begin: _dragAlignment,
      end: Alignment.center,
    ));

    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    final spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    _controller?.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller?.addListener(() {
      setState(() {
        _dragAlignment = _animation!.value;
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<CharacterIds>? character = Provider.of<List<CharacterIds>?>(context);
    print(character);
    return Scaffold(
        appBar: AppBar(
          title: Text('The Smiths Family'),
        ),
        body: ListView.builder(
            itemCount: character!.length,
            itemBuilder: (context, index) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Card(
                                  child:
                                      Image.network(character[index].image!)),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Container(
                                margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(3.0),
                                width: 100,
                                height: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                          10.0) //                 <--- border radius here
                                      ),
                                ),
                                child: GestureDetector(
                                  onPanDown: (details) {
                                    _controller?.stop();
                                  },
                                  onPanUpdate: (details) {
                                    setState(() {
                                      _dragAlignment += Alignment(
                                        details.delta.dx / (size.width / 2),
                                        details.delta.dy / (size.height / 2),
                                      );
                                    });
                                  },
                                  onPanEnd: (details) {
                                    setAnimation(details.velocity.pixelsPerSecond, size);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(character[index].name!),
                                      Text(character[index].species!)
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  ]);
            }));
  }
}
