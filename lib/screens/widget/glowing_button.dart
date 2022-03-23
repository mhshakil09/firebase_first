import 'package:flutter/material.dart';

class GlowingButton extends StatefulWidget {
  final Color color1;
  final Color color2;
  final double height;
  final double width;
  final Function onPressed;
  final IconData icon;
  final Color iconColor;
  final bool iconPositionLast;
  final double iconSize;
  final String text;
  final TextStyle textStyle;
  final double initialScale;
  final double finalScale;
  final double borderRadius;

  const GlowingButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.height,
    required this.width,
    required this.textStyle,
    this.initialScale = 1.0,
    this.finalScale = 1.02,
    this.icon = Icons.cached,
    this.iconColor = Colors.white,
    this.iconPositionLast = false,
    this.iconSize = 20,
    this.borderRadius = 40,
    this.color1 = Colors.cyan,
    this.color2 = Colors.greenAccent,
  }) : super(key: key);

  @override
  _GlowingButtonState createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton> {
  var glowing = false;
  var scale = 1.0;

  @override
  Widget build(BuildContext context) {
    //On mobile devices, gesture detector is perfect
    //However for desktop and web we can show this effect on hover too
    return GestureDetector(
      onTapUp: (val) {
        setState(() {
          glowing = false;
          scale = widget.initialScale;
        });
        widget.onPressed();
      },
      onTapDown: (val) {
        setState(() {
          glowing = true;
          scale = widget.finalScale;
        });
      },
      child: AnimatedContainer(
        transform: Matrix4.identity()..scale(scale),
        duration: Duration(milliseconds: 100),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              colors: [
                widget.color1,
                widget.color2,
              ],
            ),
            boxShadow: glowing
                ? [
                    BoxShadow(
                      color: widget.color1.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 16,
                      offset: Offset(-8, 0),
                    ),
                    BoxShadow(
                      color: widget.color2.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 16,
                      offset: Offset(8, 0),
                    ),
                    BoxShadow(
                      color: widget.color1.withOpacity(0.2),
                      spreadRadius: 16,
                      blurRadius: 32,
                      offset: Offset(-8, 0),
                    ),
                    BoxShadow(
                      color: widget.color2.withOpacity(0.2),
                      spreadRadius: 16,
                      blurRadius: 32,
                      offset: Offset(8, 0),
                    )
                  ]
                : []),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon != Icons.cached && !widget.iconPositionLast
                ? Icon(
                    widget.icon,
                    color: widget.iconColor,
                    size: widget.iconSize,
                  )
                : const SizedBox(),
            widget.icon != Icons.cached && !widget.iconPositionLast ? SizedBox(width: 6) : const SizedBox(),
            Text(
              widget.text,
              style: widget.textStyle,
            ),
            widget.icon != Icons.cached && widget.iconPositionLast ? SizedBox(width: 6) : const SizedBox(),
            widget.icon != Icons.cached && widget.iconPositionLast
                ? Icon(
                    widget.icon,
                    color: widget.iconColor,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
