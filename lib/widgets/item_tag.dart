import 'package:flutter/material.dart';

class ItemTag extends StatelessWidget {
  const ItemTag({Key? key, required this.text, required this.color})
      : super(key: key);
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: color, width: 5))),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 30.0),
      ),
    );
  }
}
