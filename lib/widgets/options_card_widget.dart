import 'package:flutter/material.dart';
import 'package:quiz_app/constants/color_constants.dart';

class OptionsCard extends StatelessWidget {
  final String option;

  final Color color;
  const OptionsCard({
    super.key,
    required this.option,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    Color txtcolor;
    if (color == wrong || color == correct) {
      txtcolor = neutral;
    } else {
      txtcolor = Colors.black;
    }
    return Card(
      color: color,
      child: ListTile(
        title: Text(
          option,
          style: TextStyle(
            fontSize: 22,
            color: txtcolor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
