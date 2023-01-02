import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quiz_app/constants/color_constants.dart';
import 'package:quiz_app/questions.dart';
import 'package:quiz_app/widgets/options_card_widget.dart';
import 'package:quiz_app/widgets/question_widget.dart';
import 'package:quiz_app/widgets/score_board.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  int score = 0;
  bool isClicked = false;
  bool isAlreadySelected = false;

  int? bestScore;
  int? page;
  final pageViewController = PageController();

  void nextQuestion() async {
    if (index == questions.length - 1) {
      storeBestScore(score);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => ScoreBoard(
          questionLength: questions.length,
          score: score,
          onStartOver: reTake,
        ),
      );
    } else {
      if (isClicked) {
        setState(() {
          index++;
          isClicked = false;
          isAlreadySelected = false;
        });
        page = 0;
        pageViewController.nextPage(
            duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select any options'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(vertical: 20),
          ),
        );
      }
    }
  }

  void isSelectedAndUpdateScore(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value) {
        score++;
      }
      setState(() {
        isClicked = true;
        isAlreadySelected = true;
      });
    }
    nextQuestion();
  }

  void reTake() {
    setState(() {
      index = 0;
      score = 0;
      isClicked = false;
      isAlreadySelected = false;
    });
    Navigator.of(context).pop();
    loadBestscore();
    pageViewController.animateToPage(
      0,
      duration: const Duration(milliseconds: 1),
      curve: Curves.easeOut,
    );
  }

  void storeBestScore(int score) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    int? _bestScore = sharedPrefs.getInt('bestscore');

    if (_bestScore != null) {
      if (score > 0 && score > _bestScore) {
        await sharedPrefs.setInt('bestscore', score);
      } else {
        return;
      }
    } else {
      _bestScore = 0;
      if (score > 0 && score > _bestScore) {
        await sharedPrefs.setInt('bestscore', score);
      } else {
        return;
      }
    }
  }

  void loadBestscore() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    int? _bestScore = sharedPrefs.getInt('bestscore');

    if (_bestScore == null || _bestScore == 0) {
      setState(() {
        bestScore = 0;
      });
    } else {
      setState(() {
        bestScore = _bestScore;
      });
    }
  }

  @override
  void initState() {
    loadBestscore();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: background,
        title: const Text('Flutter Quiz App'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Text(
              'Best Score:$bestScore',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageViewController,
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                QuestionWidget(
                  question: questions[index].title,
                  index: index,
                  totalQuestions: questions.length,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                for (int i = 0; i < questions[index].options.length; i++)
                  GestureDetector(
                    onTap: () => isSelectedAndUpdateScore(
                        questions[index].options.values.toList()[i]),
                    child: OptionsCard(
                      option: questions[index].options.keys.toList()[i],
                      color: isClicked
                          ? questions[index].options.values.toList()[i] == true
                              ? correct
                              : wrong
                          : neutral,
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
