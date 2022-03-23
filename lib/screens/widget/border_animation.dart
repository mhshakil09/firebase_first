import 'package:flutter/material.dart';

class BorderAnimationRound extends StatefulWidget {
  final Widget child;
  final double height;
  final double width;
  final int duration;
  final Color backgroundColor, borderColor, shadowColor;

  const BorderAnimationRound({
    Key? key,
    required this.child,
    this.height = 100,
    this.width = 150,
    this.duration = 1,
    this.backgroundColor = Colors.black,
    this.borderColor = Colors.blue,
    this.shadowColor = Colors.black,
  }) : super(key: key);

  @override
  _BorderAnimationRoundState createState() => _BorderAnimationRoundState();
}

class _BorderAnimationRoundState extends State<BorderAnimationRound> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: widget.duration));
    _controller
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.forward(from: 0);
        }
      })
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 3,
            color: widget.shadowColor,
          )
        ],
        gradient: SweepGradient(
          startAngle: 4,
          colors: [widget.backgroundColor, widget.borderColor],
          transform: GradientRotation(_controller.value * 6),
        ),
      ),
      child: widget.child,
      // child: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Container(
      //     decoration: const BoxDecoration(
      //       color: Colors.white,
      //     ),
      //     alignment: Alignment.center,
      //     child: const Text("Hello"),
      //   ),
      // ),
    );
  }
}
