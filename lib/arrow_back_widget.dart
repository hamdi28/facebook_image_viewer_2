import 'package:flutter/material.dart';

/// A left arrow widget that takes a color and padding arguments with onTap Function
class LeftArrow extends StatelessWidget {
  final Function() onTap;
  final bool isWhite;

  LeftArrow({required this.onTap, this.isWhite = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white,
      onTap: onTap,
      child:
          Icon(Icons.arrow_back, color: isWhite ? Colors.white : Colors.black),
    );
  }
}
