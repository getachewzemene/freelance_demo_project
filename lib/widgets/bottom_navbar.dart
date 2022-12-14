import "package:flutter/material.dart";

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {Key? key,
      required this.icon,
      required this.onPressed,
      required this.color,
      required this.width,
      required this.height})
      : super(key: key);
  final Icon icon;
  final VoidCallback onPressed;
  final Color color;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: color),
              borderRadius: BorderRadius.circular(50.0)),
          child: IconButton(
            onPressed: onPressed,
            iconSize: 40.0,
            icon: icon,
          ),
        ),
      ),
    );
  }
}
