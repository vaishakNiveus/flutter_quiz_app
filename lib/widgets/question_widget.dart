import 'package:flutter/material.dart';
import 'package:quiz_app/constants/color_constants.dart';

class QuestionWidget extends StatelessWidget {
  final String question;
  final int index;
  final int totalQuestions;

  const QuestionWidget({
    super.key,
    required this.question,
    required this.index,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      child: Text(
        'Question ${index + 1}\n\n$question',
        style: TextStyle(
          color: neutral,
          fontSize: 24,
        ),
      ),
    );
  }
}
