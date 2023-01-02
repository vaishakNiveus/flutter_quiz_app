import 'package:flutter/material.dart';
import 'package:quiz_app/constants/color_constants.dart';

class ScoreBoard extends StatelessWidget {
  final int score;
  final int questionLength;
  final VoidCallback onStartOver;

  const ScoreBoard({
    super.key,
    required this.score,
    required this.questionLength,
    required this.onStartOver,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurpleAccent,
      content: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Score",
              style: TextStyle(color: neutral, fontSize: 50),
            ),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundColor: score == questionLength / 2
                  ? Colors.yellow
                  : score < questionLength / 2
                      ? wrong
                      : correct,
              child: Text(
                '$score/$questionLength',
                style: TextStyle(color: neutral, fontSize: 50),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              score == questionLength / 2
                  ? 'Average'
                  : score < questionLength / 2
                      ? 'Poor...try again?'
                      : 'Awesome!',
              style: TextStyle(
                color: neutral,
              ),
            ),
            GestureDetector(
              onTap: onStartOver,
              child: const Text(
                'Start Over',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  letterSpacing: 1.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
