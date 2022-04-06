import 'package:flutter/cupertino.dart';
import 'package:flutter/physics.dart';


class DraggableCard extends StatefulWidget {
  const DraggableCard({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  _DraggableCardState createState() => _DraggableCardState();
}


class _DraggableCardState extends State<DraggableCard> with ChangeNotifier, SingleTickerProviderStateMixin{

  AnimationController? _controller;
  late  Alignment  _dragAlignment = Alignment.center;
  Animation<Alignment>? _animation;

  void setAnimation(Offset pixelsPerSecond, Size size){
    _animation = _controller!.drive(
        AlignmentTween(
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

    _controller!.animateWith(simulation);
  }


@override
void initState() {
  super.initState();
  _controller = AnimationController(vsync: this);

  _controller!.addListener(() {
    setState(() {
      _dragAlignment = _animation!.value;
    });
  });
}

@override
void dispose() {
  _controller!.dispose();
  super.dispose();
}


@override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}